Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBNNiq>; Wed, 14 Feb 2001 08:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129093AbRBNNih>; Wed, 14 Feb 2001 08:38:37 -0500
Received: from cs.columbia.edu ([128.59.16.20]:20211 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S129051AbRBNNic>;
	Wed, 14 Feb 2001 08:38:32 -0500
Date: Wed, 14 Feb 2001 05:38:29 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
        Alan Cox <alan@redhat.com>, Donald Becker <becker@scyld.com>,
        Jes Sorensen <jes@linuxcare.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device
In-Reply-To: <E14T1dB-0004s2-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0102140535470.14404-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2001, Alan Cox wrote:

> > The way I understand it, IA64 and Alpha cope with it, but at the expense 
> > of taking an exception for each packet -- so it's not worth it.
> 
> You want to copy_checksum the frame on these platforms, 

That's what we're doing...

> or better yet use
> a decent network card that can start the frame on odd word alignment. You need
> either the CPU or card to be able to handle misaligns efficiently.

Oh well. It's not too bad as long as Rx traffic is kept to a minimum, 
because Tx is not affected. So use it for anon ftp servers or web servers. 
:)

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

