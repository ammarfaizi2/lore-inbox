Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVBGV7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVBGV7z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 16:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVBGV7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 16:59:55 -0500
Received: from relay.axxeo.de ([213.239.199.237]:62933 "EHLO relay.axxeo.de")
	by vger.kernel.org with ESMTP id S261339AbVBGV7y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 16:59:54 -0500
From: Ingo Oeser <ioe-lkml@axxeo.de>
To: Michelle Konzack <linux4michelle@freenet.de>
Subject: Re: [PATCH] Re: msdos/vfat defaults are annoying
Date: Mon, 7 Feb 2005 22:59:46 +0100
User-Agent: KMail/1.7.1
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <4205AC37.3030301@comcast.net> <20050207084709.GA30680@ojjektum.uhulinux.hu> <20050207125353.GK12705@freenet.de>
In-Reply-To: <20050207125353.GK12705@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200502072259.46602.ioe-lkml@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michelle Konzack schrieb:
> Am 2005-02-07 09:47:09, schrieb Pozsár Balázs:
> > See? I _have_ that patch applied, that's why it tried vfat and not msdos
> > first.
>
> With this, you will nerver mount a Filesystem "msdos".
>
> Because "vfat" IS "msdos" + "lfn".
>
> You can attach to ALL "msdos" media "lfn" and you will have "vfat".

So msdos is vfat WITHOUT lfn, which is a a restriction like noatime
or mounting ext3 as ext2.

That's why the default should be vfat indeed and the restriction should be
"nolfn", which will not allow lfns to be created and is what you actually 
intend, right?

But this will break API today, so it should be added to list of
features that will change.

Regards

Ingo Oeser

