Return-Path: <linux-kernel-owner+w=401wt.eu-S1762931AbWLKONN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762931AbWLKONN (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 09:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762930AbWLKONM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 09:13:12 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52024 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762918AbWLKONL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 09:13:11 -0500
Date: Mon, 11 Dec 2006 14:19:56 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       Catalin Marinas <catalin.marinas@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ata_piix: use piix_host_stop() in ich_pata_ops
Message-ID: <20061211141956.5d161c9f@localhost.localdomain>
In-Reply-To: <20061211132625.GA18947@htj.dyndns.org>
References: <b0943d9e0612091454j6df1fb0ej2fa006c3fa33abae@mail.gmail.com>
	<20061211132625.GA18947@htj.dyndns.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2006 22:26:25 +0900
Tejun Heo <htejun@gmail.com> wrote:

> piix_init_one() allocates host private data which should be freed by
> piix_host_stop().  ich_pata_ops wasn't converted to piix_host_stop()
> while merging, leaking 4 bytes on driver detach.  Fix it.
> 
> This was spotted using Kmemleak by Catalin Marinas.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@gmail.com>

Acked-by: Alan Cox <alan@redhat.com>
