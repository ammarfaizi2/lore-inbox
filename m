Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269065AbUI2VuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269065AbUI2VuD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 17:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269070AbUI2VuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 17:50:03 -0400
Received: from imap.gmx.net ([213.165.64.20]:30876 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269065AbUI2Vt6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 17:49:58 -0400
X-Authenticated: #7318305
Date: Wed, 29 Sep 2004 23:52:38 +0200
From: Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: dri-devel@lists.sourceforge.net, xorg@freedesktop.org,
       linux-kernel@vger.kernel.org
Subject: Re: New DRM driver model - gets rid of DRM() macros!
Message-Id: <20040929235238.46c55c58.felix@trabant>
In-Reply-To: <9e4733910409280854651581e2@mail.gmail.com>
References: <9e4733910409280854651581e2@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2004 11:54:35 -0400
Jon Smirl <jonsmirl@gmail.com> wrote:

> I've checked two new directories into DRM CVS for Linux 2.6 -
> linux-core, shared-core. This code implements a new model for DRM
> where DRM is split into a core piece and personality modules that
> share the core. The major reason for doing this is that it allows me
> to remove all of the DRM() macros; something that is causing lot's of
> complaints from the Linux kernel people.

A single savage works just fine. This is lsmod output with X running:

Module                  Size  Used by
savage                  3520  0
drm                    62500  3 savage

Is it normal that the savage module looks unused? I can actually rmmod
the savage module while X is running. After that direct rending fails
with some error message about permissions ... reloading savage didn't
help (of course, because X wouldn't reinitialize it). A bit later the
box locked up. Is this 0 usage count and the ability to rmmod the module
while X is running specific to the savage driver or do other drivers
show the same behaviour?

Some questions about future driver development: So the new linux-core
and shared-core are the place to do new driver development? If this is
correct then it will be for 2.6 kernels only, right? I suppose there
would some back-porting effort involved in getting a future savage
driver to work with 2.4 again (like adding back all the DRM() macros).

> 
[snip]
> -- 
> Jon Smirl
> jonsmirl@gmail.com

| Felix Kühling <fxkuehl@gmx.de>                     http://fxk.de.vu |
| PGP Fingerprint: 6A3C 9566 5B30 DDED 73C3  B152 151C 5CC1 D888 E595 |
