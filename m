Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVE3LuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVE3LuV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 07:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVE3LuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 07:50:21 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:21639 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261490AbVE3LuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 07:50:13 -0400
Date: Mon, 30 May 2005 13:50:09 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Pavel Fedin <sonic_amiga@rambler.ru>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Full NLS support for HFS (classic) filesystem
In-Reply-To: <429B1E35.2040905@rambler.ru>
Message-ID: <Pine.LNX.4.61.0505301337040.3743@scrub.home>
References: <429B1E35.2040905@rambler.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 30 May 2005, Pavel Fedin wrote:

>   Codepage option is called "hfscodepage", not "codepage" because in
> future "codepage" option might be added to iso9660 filesystem in order
> to enable translation of 8-bit names and in many countries ISO codepage
> differs from HFS codepage.

If the codepage differs, you simply use different arguments for that 
option. Is there a _technical_ reason why "hfscodepage" and "codepage" 
might behave differently? Otherwise I'd prefer to use the same name for 
the option.

Why do you build the extra translation tables? I'm not relly convinced 
this is a kernel problem at all, but doing it more like fat would be more 
acceptable (maybe just with some more sane defaults).

(BTW please try to inline the patch otherwise it's rather difficult to 
quote from it.)

> +       if (hsb->nls)
> +       {

Please fix the coding style.

> +extern void hfs_triv2mac(struct hfs_name *, struct qstr *, unsigned char *, struct nls_table *);

If you add a new argument, use "struct superblock *sb" as the first 
argument.

bye, Roman
