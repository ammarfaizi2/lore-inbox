Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131505AbRC0XMr>; Tue, 27 Mar 2001 18:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131708AbRC0XMi>; Tue, 27 Mar 2001 18:12:38 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:30519 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S131694AbRC0XM3>;
	Tue, 27 Mar 2001 18:12:29 -0500
Message-ID: <20010328011148.A8265@win.tue.nl>
Date: Wed, 28 Mar 2001 01:11:48 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Jorge Nerin <comandante@zaralinux.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Win keys not working in console (2.4.x)
In-Reply-To: <3AC1072E.4080005@zaralinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3AC1072E.4080005@zaralinux.com>; from Jorge Nerin on Tue, Mar 27, 2001 at 11:33:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2001 at 11:33:34PM +0200, Jorge Nerin wrote:

> Hello, good work with 2.4.x, but I miss one thing. in early 2.3.x the MS 
> keys, you know, two flags and one "properties" key worked as navigation 
> keys in the console.
> 
> The flags get you to the "left" or "rigth" virtual console, and the 
> "properties" key put you on the last console you where before.
> 
> This was very useful when working in the console, I use the console 
> sometimes, and I miss these feature.

(i) Find out what key codes these keys generate.
Vaguely I seem to recall that I made these keys produce 125, 126, 127.
(the test command is "showkey")

(ii) Use loadkeys to assign functions to keys.
For example,
% loadkeys
keycode 125 = Incr_Console
keycode 126 = Decr_Console
keycode 127 = Last_Console
^D
should give you the desired behaviour.
Perhaps you lost some settings during an upgrade.

See loadkeys(1) and keytables(5).
