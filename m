Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271749AbRHURTT>; Tue, 21 Aug 2001 13:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271748AbRHURTL>; Tue, 21 Aug 2001 13:19:11 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:27151 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S271749AbRHURTB>; Tue, 21 Aug 2001 13:19:01 -0400
Message-Id: <200108211719.f7LHIvY95432@aslan.scsiguy.com>
To: Sven Heinicke <sven@research.nj.nec.com>
cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
Subject: Re: With Daniel Phillips Patch (was: aic7xxx with 2.4.9 on 7899P) 
In-Reply-To: Your message of "Tue, 21 Aug 2001 12:48:17 EDT."
             <15234.37073.974320.621770@abasin.nj.nec.com> 
Date: Tue, 21 Aug 2001 11:18:57 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Disk access is faster then before but still slower then the IDE
>drive.  Any ideas?

It could be the occasionall ordered tag that is sent to the drive to
prevent tag starvation.  If you search in drivers/scsi/aic7xxx/aic7xxx_linux.c
for "OTAG_THRESH" and make that if test always fail (add an "&& 0") you will
have effectively disabled this feature.  I should probably make it an option
that defaults to off.

--
Justin
