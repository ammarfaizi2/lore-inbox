Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281434AbRKEXln>; Mon, 5 Nov 2001 18:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281435AbRKEXle>; Mon, 5 Nov 2001 18:41:34 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:12043 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S281434AbRKEXlW>; Mon, 5 Nov 2001 18:41:22 -0500
Date: Tue, 6 Nov 2001 00:41:18 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: disk throughput
Message-ID: <20011106004118.C25602@emma1.emma.line.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3BE5F5BF.7A249BDF@zip.com.au>, <3BE5F5BF.7A249BDF@zip.com.au> <20011105132346.B5805@emma1.emma.line.org> <3BE71529.F781EF2A@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3BE71529.F781EF2A@zip.com.au>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Nov 2001, Andrew Morton wrote:

> write-behind is enabled.  I'm not religious about write-behind.
> Yes, there's a small chance that the disk will decide to write a
> commit block in front of the data (which is at lower LBAs).  But

Well, you're talking about performance here. In my simple tests, the
write cache has a major impact (twofold) on linear writes (just dd to
a partition), so your milage may vary a lot depending on the cache
configuration.
