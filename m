Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316465AbSGLOF2>; Fri, 12 Jul 2002 10:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316477AbSGLOF1>; Fri, 12 Jul 2002 10:05:27 -0400
Received: from speech.linux-speakup.org ([129.100.109.30]:48591 "EHLO
	speech.braille.uwo.ca") by vger.kernel.org with ESMTP
	id <S316465AbSGLOF0>; Fri, 12 Jul 2002 10:05:26 -0400
From: Kirk Reiser <kirk@braille.uwo.ca>
To: linux-kernel@vger.kernel.org
Subject: Advice saught on math functions
Message-Id: <E17T15g-0007mP-00@speech.braille.uwo.ca>
Date: Fri, 12 Jul 2002 10:08:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks:  What I am striving to do is build a software based speech
synthesizer into a linux driver.  It is a greatly hacked version of
rsynth I call tuxtalk.  My problem is that I have the code so far cut
down to about 66k without the shared library routines.  When I
staticly build the object comes out to over 512k.  Obviously this is
to large to want built-in to the kernel.  The majority of the size is
from libm.a.  There are five functions I need from the library, log(),
log10(), exp() cos() and sin().

My questions are:
Are these functions which are supplied by the FPU?  I've looked
through the fpu emulation headers and exp() is the only one I can find
any reference to.

Is there a better method to provide these functions than to pull them
out of libm.a?

I appreciate any suggestions or recommendations people may have on
these questions.

  Kirk
