Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289493AbSAVWcb>; Tue, 22 Jan 2002 17:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289495AbSAVWcW>; Tue, 22 Jan 2002 17:32:22 -0500
Received: from smtp010.mail.yahoo.com ([216.136.173.30]:53512 "HELO
	smtp010.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S289492AbSAVWcJ> convert rfc822-to-8bit; Tue, 22 Jan 2002 17:32:09 -0500
From: Steve Brueggeman <xioborg@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon PSE/AGP Bug
Date: Tue, 22 Jan 2002 16:32:07 -0600
Message-ID: <43qr4ukksvhs2sqssmjoki5a6g1k2g62kv@4ax.com>
In-Reply-To: <1011610422.13864.24.camel@zeus> <20020121.053724.124970557.davem@redhat.com> <20020121.053724.124970557.davem@redhat.com> <20020121175410.G8292@athlon.random> <3C4C5B26.3A8512EF@zip.com.au> <o7cp4ukpr9ehftpos1hg807a9hfor7s55e@4ax.com> <hbep4uka8q6t1tfv6694sjtvfrulipg3a4@4ax.com> <87k7uakutl.fsf@CERT.Uni-Stuttgart.DE>
In-Reply-To: <87k7uakutl.fsf@CERT.Uni-Stuttgart.DE>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yep, that was the first thing that crossed my mind.  

I had a floppy with memtest86 installed on it, and it ran for 4 hours
without any errors.  Since I've seen memtest86 find bad bits on memory
modules
that normally worked for me, I figured that this must surely indicate 
that my segfaults are not related to bad memory subsystem.

Also, while I expect setting the command line option
mem=nopentium
would slow things down slightly, I don't think that they'd be so slow
as to hide the bad memory.  Also, the segfaults happen VERY reliably
without the mem=nopentium option, and have not happened even once, 
WITH the mem=nopentium option.

One more curious thing is, I've got 64MB GForce-2 MX, and the largest
I can set my AGP aparature size to is 64MB.  Maybe a boundary
condition thing???


On Tue, 22 Jan 2002 21:13:42 +0100, you wrote:

>Steve Brueggeman <brewgyman@mediaone.net> writes:
>
>> Forgot to mention, I got the segfaults compiling kernels while running
>> linux-2.4.17, I was in console, and did not have Frame Buffer, or drm drivers
>> loaded.  I did have the SiS AGP compiled into the kernel though.
>
>On my new system at home, I got similar segfaults.  Running memtest86
>revealed that one of the RAM modules had a problem--and if I swapped
>them, the BIOS startup code wouldn't even expand the actual BIOS code
>every other system boot.  After removing the offending RAM module (and
>later replacing it) the problems were completely gone and haven't
>returned yet...
>
>Fortunately, I didn't know of the PSE/AGP bug back then.  This made
>debugging much, much easier. ;-)


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

