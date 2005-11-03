Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751581AbVKCDku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbVKCDku (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 22:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbVKCDkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 22:40:49 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:39326
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751548AbVKCDkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 22:40:49 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: initramfs for /dev/console with udev?
Date: Wed, 2 Nov 2005 21:40:24 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <20051102222030.GP23316@pengutronix.de>
In-Reply-To: <20051102222030.GP23316@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511022140.25268.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 November 2005 16:20, Robert Schwebel wrote:
> Hi,
>
> If I understand Documentation/early-userspace/README correctly it should
> be possible to solve the "unable to open an initial console" problem by
> using a file like
>
> dir /dev 0755 0 0
> nod /dev/console 0600 0 0 c 5 1
> nod /dev/null 0600 0 0 c 1 3
> dir /root 0700 0 0
>
> and let CONFIG_INITRAMFS_SOURCE point to that file. The gpio archive is
> built correctly with that, but my kernel doesn't seem to use it.

1) You have no init in initramfs, so it goes ahead and mounts whatever root= 
points to over it.  I'm guessing that's where it's looking for /dev/console 
from.

2) What's the directory /root for?

> Is anything else needed to use an initrd, like a command line argument?
> My kernel boots from a nfs partition, so it sets nfsroot=...

Note that initramfs and initrd and very different things.

> As I still get the "unable to open an initial console" message it looks
> like the initramfs is not extracted, mounted or however that works.
>
> Robert

Rob
