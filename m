Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316573AbSGLOtX>; Fri, 12 Jul 2002 10:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316574AbSGLOtW>; Fri, 12 Jul 2002 10:49:22 -0400
Received: from speech.linux-speakup.org ([129.100.109.30]:20177 "EHLO
	speech.braille.uwo.ca") by vger.kernel.org with ESMTP
	id <S316573AbSGLOtV>; Fri, 12 Jul 2002 10:49:21 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Advice saught on math functions
References: <E17T1a9-00037I-00@the-village.bc.nu>
From: Kirk Reiser <kirk@braille.uwo.ca>
Date: 12 Jul 2002 10:52:07 -0400
In-Reply-To: <E17T1a9-00037I-00@the-village.bc.nu>
Message-ID: <x7ptxtdmnc.fsf@speech.braille.uwo.ca>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> You can't use FPU operations in the x86 kernel.

That answers that! 'grin'

> Maybe you should do this in user space ? Certainly the more I talk to people
> like Nicholas Pitre the more it seems to me that most of the kernel side
> stuff is the wrong approach.

I agree, except for providing access from the very beginning.  If
access can be provided which would never leave the blind user without
speech with a user space solution this would be ideal.

> Instead would it not be better to
> 
> -	Fix select on /dev/vcsa to work
> -	During init start up after init processes are running have
> 	the init tasks (or for that matter the kernel) fire up the
> 	speech helper

Can you give me more details?  I certainly don't mind looking into
this as a possible solution.  Are you willing to give up seeing
anything on the screen until init gets started?

> The fact 95% of the speakup drivers are going to spontaneously go 
> obsolete the moment serial ports vanish bothers me.

It bothers me as well.  I am currently working toward trying to make
them into standard drivers which can be loaded as modules.  We have
new synths coming along which are pci, usb and pcmcia that would be
easier to integrate if I used a standard driver interface.

I am getting a lot of pressure to make some sort of software synth
solution available for folks that cannot afford a hardware synth or
use a platform which doesn't support hardware synths.  I also have an
over all philosophy which requires me to provide solutions that
include speech and review capabilities from power up to power down.
Open BIOS and Linux for the first time ever can provide a way for the
blind community to not be a second class citizen to information
access.  I am afraid that if I just take the emacspeak approach to
accessibility then my community will stay beholding to others for
their access to available information.  I am sorry about the soap-box
preaching but it is a fundamental problem with just user space
solutions.

  Kirk

-- 

Kirk Reiser				The Computer Braille Facility
e-mail: kirk@braille.uwo.ca		University of Western Ontario
phone: (519) 661-3061
