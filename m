Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262547AbSJ0UFK>; Sun, 27 Oct 2002 15:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262576AbSJ0UFK>; Sun, 27 Oct 2002 15:05:10 -0500
Received: from air-2.osdl.org ([65.172.181.6]:36058 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262547AbSJ0UFI>;
	Sun, 27 Oct 2002 15:05:08 -0500
Date: Sun, 27 Oct 2002 12:08:04 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <dash@xdr.com>
cc: <jsimmons@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.40 bug related to virtual consoles
Message-ID: <Pine.LNX.4.33L2.0210271129090.8100-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Regarding "2.5.40 bug related to virtual consoles":
http://marc.theaimsgroup.com/?l=linux-kernel&m=103403138113853&w=2

Hi David,

Did you have some (private) replies to this?
If so, is it solved?

There are console & framebuffer updates pending, but I
don't know if they would solve this problem (which is
quite easy to reproduce).

The vc (virtual console) code appears to expect (eh, require)
some console (data struct) to be present.  For now, if you
enable Frame Buffer support but don't select/enable any
FB devices, you'll just get the dummy console driver, and
the vc code will be happy (at least it booted without an
error for me on 2.5.44).  In my system (x86), this added
about 60 KB of code... :(

-- 
~Randy


