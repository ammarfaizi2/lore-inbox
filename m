Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265177AbTLaP3n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 10:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265179AbTLaP3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 10:29:43 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:13572 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265177AbTLaP2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 10:28:01 -0500
Subject: Re: 2.6.0-mm2 Surprises
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Danny Cox <Danny.Cox@ECWeb.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1072880245.1146.11.camel@vom>
References: <1072880245.1146.11.camel@vom>
Content-Type: text/plain
Message-Id: <1072884476.2796.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Wed, 31 Dec 2003 16:27:57 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-12-31 at 15:17, Danny Cox wrote:

> First, 'make menuconfig' doesn't work.  It paints the top 8 or so lines,
> and freezes.  gnome-terminal begins using as much CPU as it's allowed. 
> This is similar to bug 959 in bugme.osdl.org, but changing CHILD_PENALTY
> from 90 to 130 didn't fix the problem.
> 
> Second, simply resizing gnome-terminal results in the same behavior. 
> Certainly, this may be a gnome thing.

It's a known issue with gnome-terminal. You'll need to upgrade to the
latest gnome-terminal and vte packages.

"make menuconfig" works nicely here under KDE and text-only console.

> Third, 'rpm' cannot install packages.  It always exists with:
> 
> rpmdb: unable to join the environment
> error: db4 error(11) from dbenv->open: Resource temporarily unavailable
> error: cannot open Packages index using db3 - Resource temporarily
> unavailable (11)
> error: cannot open Packages database in /var/lib/rpm

Again, this is not a kernel problem.

rm -f /var/lib/rpm/__db*

Then, try "rpm -i" again.

