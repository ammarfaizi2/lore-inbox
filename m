Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136873AbREJSaL>; Thu, 10 May 2001 14:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136880AbREJSaB>; Thu, 10 May 2001 14:30:01 -0400
Received: from comverse-in.com ([38.150.222.2]:14798 "EHLO
	eagle.comverse-in.com") by vger.kernel.org with ESMTP
	id <S136873AbREJS3w>; Thu, 10 May 2001 14:29:52 -0400
Message-ID: <6B1DF6EEBA51D31182F200902740436802678EB2@mail-in.comverse-in.com>
From: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
To: "'rjd@xyzzy.clara.co.uk'" <rjd@xyzzy.clara.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Detecting Red Hat builds ?
Date: Thu, 10 May 2001 14:28:50 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For a RH7.x, at least, there is the /boot/kernel.h file generated on bootup,
and the RH kernel headers include it somewhere.
You can see if the corresponding symbols (coming from it) are defined, and
assume redhat than.
You might consider using passing -dM down to the preprocessor with the
standard driver includes preamble,
and look in the preprocessed output for a good clue - it may well be that
there is some other redhat-specific string somewhere defined.
I guess you will find smth if you egrep -i (rh|redhat).

HTH,
	Vassilii

-----Original Message-----
From: rjd@xyzzy.clara.co.uk [mailto:rjd@xyzzy.clara.co.uk]
Sent: Thursday, May 10, 2001 12:25 PM
To: linux-kernel@vger.kernel.org
Subject: Detecting Red Hat builds ?


Hi,

How can I determine if the build my device driver is being compiled under is
a standard kernel.org one or a Red Hat one ?
