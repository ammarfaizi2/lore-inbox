Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289694AbSAKLrv>; Fri, 11 Jan 2002 06:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289721AbSAKLrk>; Fri, 11 Jan 2002 06:47:40 -0500
Received: from hal.astr.lu.lv ([195.13.134.67]:8832 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S289694AbSAKLre> convert rfc822-to-8bit;
	Fri, 11 Jan 2002 06:47:34 -0500
Message-Id: <200201111147.g0BBl5a01992@hal.astr.lu.lv>
Content-Type: text/plain; charset=US-ASCII
From: Andris Pavenis <pavenis@latnet.lv>
To: Doug Ledford <dledford@redhat.com>
Subject: Re: i810_audio driver v0.19 still freezes machine
Date: Fri, 11 Jan 2002 13:47:05 +0200
X-Mailer: KMail [version 1.3.2]
Cc: tom@infosys.tuwien.ac.at, linux-kernel@vger.kernel.org
In-Reply-To: <E16Okz2-0005JM-00@the-village.bc.nu> <200201110742.g0B7gDa16387@hal.astr.lu.lv> <3C3EA5D8.7050206@redhat.com>
In-Reply-To: <3C3EA5D8.7050206@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 January 2002 10:44, Doug Ledford wrote:
> Andris Pavenis wrote:
> > On Thursday 10 January 2002 21:26, Doug Ledford wrote:
> >>Alan Cox wrote:
> >>>Make sure you test with both apic and non apic Doug. The previous hangs
> >>> I fixed up were specific to APIC mode because the APIC means the irq
> >>> arrival is later and more asynchronous
> >>
> >>I can't.  APIC makes my test machine (my only i810 machine) hang on boot
> >
> > I have both 'Local APIC support on uniprocessors' and
> > 'IO_APIC support on uniprocessors' enabled in kernel configuration.
> > Should I try i810_audio.c v0.19 after disabling APIC support in
> > kernel (v2.4.17)?
>
> No, just try the 0.20 version that I have up in the normal place.  It
> should solve your problem.

Tried. I haven't been able to freeze box after some not very long torturing 
with artsd, but there is another new trouble:

For test I'm letting artsd to play some WAV file and after that give some 
time for it to close /dev/dsp. After some times there is no more sound and 
I'm getting a message that /dev/dsp is busy when trying to restart artsd. 
Anyway I can reload i810_audio driver and restart artsd to get sound working 
again. 'fuser /dev/dsp' also doesn't show that it is opened

Andris
