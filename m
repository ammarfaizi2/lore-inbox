Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266715AbRHALPS>; Wed, 1 Aug 2001 07:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266736AbRHALO6>; Wed, 1 Aug 2001 07:14:58 -0400
Received: from speech.braille.uwo.ca ([129.100.109.30]:38921 "EHLO
	speech.braille.uwo.ca") by vger.kernel.org with ESMTP
	id <S266715AbRHALOs>; Wed, 1 Aug 2001 07:14:48 -0400
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: my patches won't compile under 2.4.7
In-Reply-To: <x7itgglrmd.fsf@speech.braille.uwo.ca>
	<E15PUnL-0002bA-00@the-village.bc.nu>
	<200107312154.f6VLsLl00530@mobilix.ras.ucalgary.ca>
From: Kirk Reiser <kirk@braille.uwo.ca>
Date: 01 Aug 2001 07:14:29 -0400
In-Reply-To: <200107312154.f6VLsLl00530@mobilix.ras.ucalgary.ca>
Message-ID: <x7u1zsav6y.fsf@speech.braille.uwo.ca>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually it wasn't Alan pointing the finger it was me.  I was only
trying to figure out what the errors meant and they pointed to
devfs_fs_kernel.h.  The problem as I suspected at eh time was entirely
unrelated.  I moved my #include of misc_devices.h up and removed a
duplicate #include for linux/init.h and poof she compiled.  I am
starting to become a believer in voodoo computing again I guess.

On another note related to devfs though when I compile devfs in the
system just hangs.  I am wondering if I am registering my synth device
before devfs has memory allocated.  I register very early in the boot
process in console_init() and experienced similar problems before because I
don't think  kmalloc() may be available that early in the sequence.

The question then is, do you think that could be why the system is
hanging with devfs configured in?

  Kirk

-- 

Kirk Reiser				The Computer Braille Facility
e-mail: kirk@braille.uwo.ca		University of Western Ontario
phone: (519) 661-3061
