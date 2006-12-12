Return-Path: <linux-kernel-owner+w=401wt.eu-S964788AbWLLXG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWLLXG4 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 18:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWLLXG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 18:06:56 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44441 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S964788AbWLLXGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 18:06:55 -0500
Date: Tue, 12 Dec 2006 23:12:37 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: mike.miller@hp.com, mikem@beardog.cca.cpqcorp.net
Cc: mikem@beardog.cca.cpqcorp.net, akpm@osdl.org, jens.axboe@oracle.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2/2] cciss: remove calls to pci_disable_device
Message-ID: <20061212231237.59581b28@localhost.localdomain>
In-Reply-To: <20061212195458.GB2471@beardog.cca.cpqcorp.net>
References: <20061212195458.GB2471@beardog.cca.cpqcorp.net>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2006 13:54:58 -0600
"Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net> wrote:

> PATCH 2/2
> 
> This patch removes calls to pci_disable_device except in fail_all_cmds. The pci_disable_device function does something nasty to Smart Array controllers that pci_enable_device does not undo. So if the driver is unloaded it cannot be reloaded.

Acked-by: Alan Cox <alan@redhat.com>

Various devices do this. Please however update the patch or add a patch
which includes comments as to why or someone will helpfully put them back
one day.
