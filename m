Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283048AbRLWBig>; Sat, 22 Dec 2001 20:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283054AbRLWBi3>; Sat, 22 Dec 2001 20:38:29 -0500
Received: from web13108.mail.yahoo.com ([216.136.174.153]:48398 "HELO
	web13108.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S283056AbRLWBiQ>; Sat, 22 Dec 2001 20:38:16 -0500
Message-ID: <20011223013815.45902.qmail@web13108.mail.yahoo.com>
Date: Sat, 22 Dec 2001 17:38:15 -0800 (PST)
From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Linux IA32 microcode driver
To: Ben Clifford <benc@hawaga.org.uk>
Cc: tigran@veritas.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112221050290.9843-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The msr driver doesn't support devfs at all, and nor
does cpuid come to that. However, microcode creates a
miscellaneous character device, number (10,184), in
the /dev/misc directory. This is why the regular
/dev/cpu/microcode file is so mysterious...

Chris

--- Ben Clifford <benc@hawaga.org.uk> wrote:
> On Sat, 22 Dec 2001, Chris Rankin wrote:
> 
> > Am I missing something rather obvious, or is the
> /dev/cpu/microcode
> > device being mis-created under devfs with Linux
> 2.4.x? I have enclosed
> > a patch to ensure that the character device really
> *is* a character
> > device.
> 
> On my system, running 2.4.16, I get no devfs entry
> for that or msr at all.
> I just get the mtrr entry.
> 
> This is with microcode and msr loaded as modules.
> 
> -- 
> Ben Clifford     benc@hawaga.org.uk
> http://www.hawaga.org.uk/ben/  GPG: 30F06950
> webcam:
>
http://barbarella.hawaga.org.uk/~benc/webcam/live.html
> 


__________________________________________________
Do You Yahoo!?
Send your FREE holiday greetings online!
http://greetings.yahoo.com
