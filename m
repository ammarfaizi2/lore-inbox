Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262912AbVBDGuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbVBDGuN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 01:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbVBDGuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 01:50:12 -0500
Received: from port49.ds1-van.adsl.cybercity.dk ([212.242.141.114]:17713 "EHLO
	trider-g7.fabbione.net") by vger.kernel.org with ESMTP
	id S262912AbVBDGqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 01:46:47 -0500
Message-ID: <42031A60.4000606@ubuntu.com>
Date: Fri, 04 Feb 2005 07:46:56 +0100
From: Fabio Massimo Di Nitto <fabbione@ubuntu.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Stephen Evanchik <evanchsa@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc3] IBM Trackpoint support
References: <a71293c20502031443764fb4e5@mail.gmail.com> <200502031934.16642.dtor_core@ameritech.net> <20050204063520.GD2329@ucw.cz>
In-Reply-To: <20050204063520.GD2329@ucw.cz>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Vojtech Pavlik wrote:
| On Thu, Feb 03, 2005 at 07:34:16PM -0500, Dmitry Torokhov wrote:
|
|>On Thursday 03 February 2005 17:43, Stephen Evanchik wrote:
|>
|>>Vojtech,
|>>
|>>Here is a patch that exposes the IBM TrackPoint's extended properties
|>>as well as scroll wheel emulation.
|>>
|>>
|>
|>Hi,
|>
|>Very nice although I have a couple of comments.
|>
|>
|>> /*
|>>+ * Try to initialize the IBM TrackPoint
|>>+ */
|>>+	if (max_proto > PSMOUSE_PS2 && trackpoint_init(psmouse) == 0) {
|>>+		psmouse->vendor = "IBM";
|>>+		psmouse->name = "TrackPoint";
|>>+
|>>+		return PSMOUSE_PS2;
|>
|>Why PSMOUSE_PS2? Reconnect will surely not like it.
|
|
| Indeed. IIRC this patch killed wheel mouse detection in ubuntu.
|

That's correct. I had to revert it unfortunatly and i am dealing to
give it another shot if you want to get it tested again
before inclusion in the main tree, but it has to happen no later than
next week since we are very close to feature freeze for the next release.

Regards,
Fabio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQgMaXlA6oBJjVJ+OAQKn7A//ULwd9zWcnqgmY0+uacKYT9LYa2hcIBuu
P9i08D/GpTGSglJ0iLBKM6eHw1eKLMwC1snVQ99TyCVMIicEBnNgcF31McEui/Q7
ZJug1Twndb0pUAc/erKUzdqLmQTIPax1eJLLCEmw81UWA0sW2PW52DZ26/4jqSFz
qpNYpvkT8h4X5Gc4l8j/erMYasN4jglcdjDKzfj6NMsVqWC5VJN5W863KPyM2dmf
BN9Mx8jDSzO6PgfquhKJa/6pUV7OODko6PwnJFkWC3SR03x8SjX7EKKDpkYW8OnX
RZGq2Tkmv5B2lme4v9e+O5+UPRzBuahxyknZw9WOcRBUeMpzAAXrIL6cDsWb9ZAd
ZCbIp3MS2be+hIY3hElbHiMN6+XLmr41u5PHGoxBOg8t4UPPTij7/ym3w4iB9Fbu
JIjEDsUfSVjzMZ0+tLGFl+2CtwrrBtmvGnuzLEzJxbwRWlzirIBj5VxAyLUVfXUB
TT0tAeDcopHqki3kFifiXUJ9XKPocwgznosZpISfNdJLB4+kw6S0/XamsbzZBJzr
K1Me547OABE8d/vc4dR7nDKqw4quZk6qThK7wqziiz6mGlBC28gLkfyxfGvVj/Uv
6uaE7RNOvRQYQNUFMMt6BH7vogCp7GsqrMfiiNc72SaxN8Gp4g2cH8v7xpUXcrJ0
mc6TtaGNagQ=
=AVn/
-----END PGP SIGNATURE-----
