Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbULJRX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbULJRX3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 12:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbULJRX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 12:23:29 -0500
Received: from relay.axxeo.de ([213.239.199.237]:55448 "EHLO relay.axxeo.de")
	by vger.kernel.org with ESMTP id S261255AbULJRXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 12:23:24 -0500
From: Ingo Oeser <ioe@axxeo.de>
Organization: Axxeo GmbH
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 4/5] NOMMU: Make POSIX shmem work on ramfs-backed files
Date: Fri, 10 Dec 2004 18:23:18 +0100
User-Agent: KMail/1.6.2
References: <200412100408.33482.ioe@axxeo.de> <200412091508.iB9F8wja027564@warthog.cambridge.redhat.com> <27481.1102688880@redhat.com>
In-Reply-To: <27481.1102688880@redhat.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200412101823.18262.ioe@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You wrote:
> Ingo Oeser <ioe@axxeo.de> wrote:
> Actually, this would probably do instead:
>
>  file-mmu-y := file-nommu.o
>  file-mmu-$(CONFIG_MMU) := file-mmu.o
>  ramfs-objs := inode.o file-mmu-y
>
> Will this work? Or should it be $(file-mmu-y) on the last line?

Yes, so actually this would cut it:

file-mmu-y := file-nommu.o
file-mmu-$(CONFIG_MMU) := file-mmu.o
ramfs-objs := inode.o $(file-mmu-y)

But you got the idea, so I'm happy already ;-)


Ingo Oeser

