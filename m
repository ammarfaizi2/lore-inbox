Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291213AbSBSLFO>; Tue, 19 Feb 2002 06:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291214AbSBSLFH>; Tue, 19 Feb 2002 06:05:07 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19726 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291213AbSBSLEs>;
	Tue, 19 Feb 2002 06:04:48 -0500
Message-ID: <3C7230E9.AD355CA9@zip.com.au>
Date: Tue, 19 Feb 2002 03:03:05 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: Samium Gromoff <root@ibe.miee.ru>, linux-kernel@vger.kernel.org
Subject: Re: NE2k driver issue
In-Reply-To: <200202191318.g1JDIcm12054@ibe.miee.ru>,
		<200202191318.g1JDIcm12054@ibe.miee.ru>; from root@ibe.miee.ru on Tue, Feb 19, 2002 at 04:18:38PM +0300 <20020219034611.F24428@lynx.adilger.int>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> On Feb 19, 2002  16:18 +0300, Samium Gromoff wrote:
> > With esd started the sound card generated 500-600 interrupts/second,
> > with no esd, it didnt generated interrupts.
> 
> This is a known problem with esd - it plays "the sound of silence" all
> the time.  This means it is generating interrupts even when you aren't
> listening to anything.
> 

But the odd thing is that the soundcard interrupts tentupled the
samba throughput.  Which sounds like a driver-handoff-to-ksoftirqd
problem. 

-
