Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVAaS4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVAaS4h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 13:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVAaS4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 13:56:37 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:51678 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S261310AbVAaS41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 13:56:27 -0500
Date: Mon, 31 Jan 2005 13:55:59 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [Watchdog] alim7101_wdt problem on 2.6.10
In-reply-to: <20050131072708.GA17354@hockin.org>
To: Tim Hockin <thockin@hockin.org>
Cc: Emmanuel Fleury <fleury@cs.aau.dk>, linux-kernel@vger.kernel.org
Message-id: <41FE7F3F.5020809@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <41FDDCA3.7090701@cs.aau.dk> <20050131072708.GA17354@hockin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Tim Hockin wrote:
> On Mon, Jan 31, 2005 at 08:22:11AM +0100, Emmanuel Fleury wrote:
> 
>>Jan 30 00:58:21 hermes vmunix: alim7101_wdt: ALi 1543 South-Bridge does
>>not have the correct revision number (???1001?) - WDT
>>not set
>>
>>What did I do wrong ?
> 
> 
> You used the wrong South Bridge revision.  Seriously, older revisions of
> M7101 did not have a WDT.  You seem to have an older revision.  Sorry.
> 

FWIW, some of the old cobalt boxes had the old south bridge revision
with a WDT.  It managed to do resets/wdt off gpio pin 5 though, and
there is a patch in Alan's 2.6.10-ac tree that handles it.

Whether or not it will work with your vaio?  Probably not, though I
guess it wouldn't hurt to try (modprobe alim7101_wdt use_gpio=1).

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB/n8/dQs4kOxk3/MRAg/HAJ4x+SdKXwNDsKrtBMS9xLYcYLYVigCdHBTk
CWSOMh5FZPmfrky713Avd4g=
=DMs9
-----END PGP SIGNATURE-----
