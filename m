Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132478AbRD2VpD>; Sun, 29 Apr 2001 17:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132054AbRD2Voo>; Sun, 29 Apr 2001 17:44:44 -0400
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:46597 "HELO
	zcamail03.zca.compaq.com") by vger.kernel.org with SMTP
	id <S136393AbRD2VoW>; Sun, 29 Apr 2001 17:44:22 -0400
From: jg@pa.dec.com (Jim Gettys)
Date: Sun, 29 Apr 2001 14:44:11 -0700 (PDT)
Message-Id: <200104292144.f3TLiBD03874@pachyderm.pa.dec.com>
X-Mailer: Pachyderm (client pachyderm.pa-x.dec.com, user jg)
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AE60A3D.9090103@holly-springs.nc.us>
Subject: Re: #define HZ 1024 -- negative effects?
Mime-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The biggest single issue in GUI responsiveness on Linux has been caused
by XFree86's implementation of mouse tracking in user space.

On typical UNIX systems, the mouse was often controlled in the kernel
driver.  Until recently (XFree86 4.0 days), the XFree86 server's reads
of mouse/keyboard events were not signal driven, so that if the X server
was loaded, the cursor stopped moving.

On most (but not all) current XFree86 implementations, this is now
signal drive, and further the internal X schedular has been reworked to
make it difficult for a single client to monopolize the X server.

So the first thing you should try is to make sure you are using an X server
with this "silken mouse" enabled; anotherwords, run XFree86 4.0x and make
sure the implementation has it enabled....

There may be more to do in Linux thereafter, but until you've done this, you
don't get to discuss the matter further....
					- Jim Gettys

--
Jim Gettys
Technology and Corporate Development
Compaq Computer Corporation
jg@pa.dec.com

