Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129401AbQKWWtn>; Thu, 23 Nov 2000 17:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130230AbQKWWtd>; Thu, 23 Nov 2000 17:49:33 -0500
Received: from boss.staszic.waw.pl ([195.205.163.66]:43783 "EHLO
        boss.staszic.waw.pl") by vger.kernel.org with ESMTP
        id <S129401AbQKWWtW>; Thu, 23 Nov 2000 17:49:22 -0500
Date: Thu, 23 Nov 2000 23:19:16 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <dake@staszic.waw.pl>
To: Patrick van de Lageweg <patrick@bitwizard.nl>
cc: Rogier Wolff <wolff@bitwizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: [NEW DRIVER] firestream
In-Reply-To: <Pine.LNX.4.21.0011221031340.995-100000@panoramix.bitwizard.nl>
Message-ID: <Pine.LNX.4.21.0011232059560.496-100000@tricky>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

Just a few hints on __init/__exit stuff...

On Wed, 22 Nov 2000, Patrick van de Lageweg wrote:

> +struct reginit_item PHY_NTC_INIT[] = {

Can be marked __initdata

> +void undocumented_pci_fix (struct pci_dev *pdev)

Can be marked __init

> +void write_phy (struct fs_dev *dev, int regnum, int val)

Can be marked __init

> +int init_phy (struct fs_dev *dev, struct reginit_item *reginit)

Can be marked __init

> +void *aligned_kmalloc (int size, int flags, int alignment)

Can be marked __init

> +int init_q (struct fs_dev *dev, 
> +	    struct queue *txq, int queue, int nentries, int is_rq)

Can be marked __init

> +int init_fp (struct fs_dev *dev, 
> +	     struct freepool *fp, int queue, int bufsize, int nr_buffers)

Can be marked __init

> +void free_queue (struct fs_dev *dev, struct queue *txq)

Can be marked __exit

> +void free_freepool (struct fs_dev *dev, struct freepool *fp)

Can be marked __exit


You may also consider processing firestream.[ch] through indent because
spacing is inconsistent - sometimes tabs, sometimes 8*space (it would
be nice too have tabs everywhere).

Regards
--
Bartlomiej Zolnierkiewicz
<bkz@linux-ide.org>


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
