Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273967AbRIRXoF>; Tue, 18 Sep 2001 19:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273968AbRIRXnz>; Tue, 18 Sep 2001 19:43:55 -0400
Received: from ash.lnxi.com ([207.88.130.242]:15867 "EHLO DLT.linuxnetworx.com")
	by vger.kernel.org with ESMTP id <S273967AbRIRXnl>;
	Tue, 18 Sep 2001 19:43:41 -0400
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LinuxBIOS + ASUS CUA + 2.4.5 works; with 2.4.6 locks up
In-Reply-To: <Pine.LNX.4.10.10109181931570.2275-100000@coffee.psychology.mcmaster.ca>
From: ebiederman@lnxi.com (Eric W. Biederman)
Date: 18 Sep 2001 17:43:59 -0600
In-Reply-To: <Pine.LNX.4.10.10109181931570.2275-100000@coffee.psychology.mcmaster.ca>
Message-ID: <m33d5kgj40.fsf@DLT.linuxnetworx.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn <hahn@physics.mcmaster.ca> writes:

> > It is hard to call.  The most interesting case I know of is the VIA kt133
> > AMD bug.  I believe it is register 0x55 bit 7 that when set causes an
> > athlon optimized memcpy to crash the machine, but when clear it works.
> 
> "causes" is a bit strong - there are plenty of machines where it 
> most definitely doesn't effect stability at all.  that is, kt133a
> machines which use Arjan's fast_copy_page without any problem,
> and yet have 0x55:7 set.  (my A7V133's is 0x89, for instance.)

Granted.  But it it does seem to be the cause for the set of systems affected.
And it nicely illustrates the point that you can have very weird problems that
don't show up under normal circumstances.

In the kt133 case it feels like a problem initializing the cpu<->northbridge bus.

In Rons case it is probably completely different.

Eric

