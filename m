Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261327AbTCOIIx>; Sat, 15 Mar 2003 03:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261328AbTCOIIw>; Sat, 15 Mar 2003 03:08:52 -0500
Received: from mako.theneteffect.com ([63.97.58.10]:23824 "EHLO
	mako.theneteffect.com") by vger.kernel.org with ESMTP
	id <S261327AbTCOIIw>; Sat, 15 Mar 2003 03:08:52 -0500
From: Mitch Adair <mitch@theneteffect.com>
Message-Id: <200303150819.h2F8JfW15921@mako.theneteffect.com>
Subject: Re: [PATCH] update filesystems config. menu
To: randy.dunlap@verizon.net (Randy.Dunlap)
Date: Sat, 15 Mar 2003 02:19:40 -0600 (CST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Randy.Dunlap" at Mar 14, 2003 11:45:48 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +config EXT2_FS
> +	tristate "Second extended fs support"

[...]

> +	  module will be called ext2.  Be aware however that the file system
> +	  of your root partition (the one containing the directory /) cannot
> +	  be compiled as a module, and so this could be dangerous.  Most
> +	  everyone wants to say Y here.
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
I seem to recall if you say Y to ext2 and Y to ext3 and your root is on ext3
then it's likely to be mounted as ext2 unless you set rootfstype=...
The ext3 help comment also warns you should set it to Y, so people with
root ext3 are likely to get a surprise if they follow both help.  Would it
be better to say something like "if your root partition is extX you almost
certainly want to say Y here"?  Or warn about the rootfstype issue maybe?

	M
