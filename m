Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264308AbTL3DFw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 22:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264337AbTL3DFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 22:05:52 -0500
Received: from smtp2.dei.uc.pt ([193.137.203.229]:64976 "EHLO smtp2.dei.uc.pt")
	by vger.kernel.org with ESMTP id S264308AbTL3DFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 22:05:49 -0500
Date: Tue, 30 Dec 2003 03:05:18 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-mm2
In-Reply-To: <200312291832.35367.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.58.0312300247570.25540@student.dei.uc.pt>
References: <20031229013223.75c531ed.akpm@osdl.org> <20031229163955.GA20207@lsc.hu>
 <Pine.LNX.4.58.0312292008430.16514@student.dei.uc.pt>
 <200312291832.35367.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-DEI-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 29 Dec 2003, Dmitry Torokhov wrote:

> On Monday 29 December 2003 03:10 pm, Marcos D. Marado Torres wrote:
> > Well, as for me, I still can't get the "mouse tap" working with my Asus
> > M3700N laptop.
>
> Does this laptop have Synaptics hardware?

Yes.

> And are you using native Synaptics
> XFree driver or running with  psmouse_proto={bare|imps|exps}?

With 2.6.0 plain or 2.6.0-mjb*

$ cat .config |grep MOUSE
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_PS2_SYNAPTICS is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_BUSMOUSE is not set
# CONFIG_USB_MOUSE is not set
$

If I select SYNAPTICS then my mouse taps are over, so I don't use synaptics at all...

In -mm sources (and as I can see in -bk1 it will be in the main branch too) the
patch to remove synaptics configuration option was added, so I have no way (as far
as I can see) to just say that I don't want to use Synaptics, so I can't solve
this problem... .config goes:

$ cat .config |grep MOUSE
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_BUSMOUSE is not set
# CONFIG_USB_MOUSE is not set
$

Of course that being my mouse a Synaptics (at least according to ASUS),
Synaptics should give me the mouse taps, but seeing it does not, I would like
at least to have the option not to compile it...

Further, the idea I got from this patch:

http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/cset-dtor_core@ameritech.net|ChangeSet|20031219053552|02923.txt

was that the option made no sense since people with no (or bad) synaptics
support wouldn't "suffer" from this (in my case I should still have those mouse
taps...)

Well, there's a chance that there's something I am doing wrong or somewhere my
logic fails, so feedback on this is wanted...

> Native absolute
> mode -> relative PS/2 protocol translation that is done by mousedev does not
> do taps. At all.
>
> Dmitry
>

Thanks,
Mind Booster Noori

- --
==================================================
Marcos Daniel Marado Torres AKA Mind Booster Noori
/"\               http://student.dei.uc.pt/~marado
\ /                       marado@student.dei.uc.pt
 X   ASCII Ribbon Campaign
/ \  against HTML e-mail and Micro$oft attachments
==================================================

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQE/8OtxmNlq8m+oD34RAnlwAKCUl6a7dGV8ptMEv14wF/8uy54bVwCfW7DN
IMhIbajRQ0oH3lxlHnejwlw=
=5fvZ
-----END PGP SIGNATURE-----

