Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbUL0BnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbUL0BnP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 20:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbUL0BnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 20:43:15 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:14792 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S261681AbUL0BlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 20:41:18 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Prezeroing V2 [3/4]: Add support for ZEROED and NOT_ZEROED free maps
Date: Mon, 27 Dec 2004 02:37:46 +0100
User-Agent: KMail/1.6.2
Cc: Florian Weimer <fw@deneb.enyo.de>, Linus Torvalds <torvalds@osdl.org>,
       7eggert@gmx.de, Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
       linux-ia64@vger.kernel.org, linux-mm@kvack.org
References: <fa.n0l29ap.1nqg39@ifi.uio.no> <Pine.LNX.4.58.0412261511030.2353@ppc970.osdl.org> <87llbk63sn.fsf@deneb.enyo.de>
In-Reply-To: <87llbk63sn.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200412270237.53368.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 27 December 2004 00:24, Florian Weimer wrote:
> By the way, some crazy idea that occurred to me: What about
> incrementally scrubbing a page which has been assigned previously to
> this CPU, while spinning inside spinlocks (or busy-waiting somewhere
> else)?

Crazy idea, indeed. spinlocks are like safety belts: You should
actually not need them in the normal case, but they will save your butt
and you'll be glad you have them, when they actually trigger.

So if you are making serious progress here, you have just uncovered
a spinlockcontention problem in the kernel ;-)

Regards

Ingo Oeser

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBz2dvU56oYWuOrkARAvc+AJ0RpaIg6JzC28B8SOXE3irCBtaTVgCg1eas
5zACIzV2CtvlNvg6Bit+/G8=
=rdE7
-----END PGP SIGNATURE-----
