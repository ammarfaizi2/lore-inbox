Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbUKCQ6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbUKCQ6c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 11:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbUKCQ6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 11:58:31 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:61323 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261725AbUKCQ62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 11:58:28 -0500
Date: Wed, 3 Nov 2004 17:56:46 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: blaisorblade_spam@yahoo.it
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, julian@sektor37.de,
       mcr@sandelman.ottawa.on.ca, sam@ravnborg.org
Subject: Re: [patch 2/2] kbuild: fix crossbuild base config
In-Reply-To: <20041102232001.370174C0BC@zion.localdomain>
Message-ID: <Pine.LNX.4.61.0411031747020.17266@scrub.home>
References: <20041102232001.370174C0BC@zion.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 3 Nov 2004 blaisorblade_spam@yahoo.it wrote:

> This has actually created not-working UML binaries (since UML is always
> "cross-compiled" for this purpose), as reported by Julian Scheid.

This rather suggests, there is a problem with UML. Either fix your Kconfig 
to prevent nonvalid configurations or detect and report the problem at 
runtime.

> We all agreed on this kind of general, not UML-only fix, and I (Paolo)
> implemented it.

I don't like the two separate lists, it would be easier to just skip all 
absolute path names.
I would also like to avoid this patch at all. If this really should be a 
problem, I'd consider to don't run kconfig at all in this case if there 
is no configuration and instead suggest running defconfig (or one of 
machine specific config targets) first.

bye, Roman
