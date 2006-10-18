Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWJRAOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWJRAOF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 20:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWJRAOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 20:14:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30951 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751283AbWJRAOC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 20:14:02 -0400
Date: Tue, 17 Oct 2006 17:10:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
Cc: jens.axboe@suse.de, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2/2] cciss: disable dma prefetch for P600
Message-Id: <20061017171021.baea3c3f.akpm@osdl.org>
In-Reply-To: <20061017211303.GB17874@beardog.cca.cpqcorp.net>
References: <20061017211303.GB17874@beardog.cca.cpqcorp.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2006 16:13:03 -0500
"Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net> wrote:

> PATCH 2/2
> Turned off DMA prefetch for the P600 on systems which may present
> discontiguous memory.
> 

What do you mean by "discontiguous memory"?  CONFIG_DISCONTIGMEM?

What is the actual problem which is being fixed here?

> +#if defined CONFIG_IA64 || if defined CONFIG_X86_64

hm, does that work?

I'll change it to

#if defined(CONFIG_IA64) || defined(CONFIG_X86_64)


