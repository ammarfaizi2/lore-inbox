Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266665AbRGJRYg>; Tue, 10 Jul 2001 13:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266667AbRGJRYR>; Tue, 10 Jul 2001 13:24:17 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:62215 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S266665AbRGJRYJ>; Tue, 10 Jul 2001 13:24:09 -0400
Date: Tue, 10 Jul 2001 10:24:00 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] starfire net driver update
In-Reply-To: <3B4B3209.40F5519F@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0107101022180.13462-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2001, Jeff Garzik wrote:

> Ion Badulescu wrote:
> > +       unregister_netdev(dev);                 /* Will also free np!! */
> > +       iounmap((char *)dev->base_addr);
> > +       pci_release_regions(pdev);
> > 
> >         pci_set_drvdata(pdev, NULL);
> > +       kfree(dev);
> 
> no problem with the patch, this comment is wrong though.  kfree frees
> np.

True, the comment should be moved 5 lines down. I'll fix it in the next 
version.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

