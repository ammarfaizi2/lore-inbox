Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266661AbRGJQtf>; Tue, 10 Jul 2001 12:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266665AbRGJQt0>; Tue, 10 Jul 2001 12:49:26 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:4571 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S266661AbRGJQtN>;
	Tue, 10 Jul 2001 12:49:13 -0400
Message-ID: <3B4B3209.40F5519F@mandrakesoft.com>
Date: Tue, 10 Jul 2001 12:49:13 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ion Badulescu <ionut@cs.columbia.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] starfire net driver update
In-Reply-To: <Pine.LNX.4.33.0107100932230.13462-100000@age.cs.columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:
> +       unregister_netdev(dev);                 /* Will also free np!! */
> +       iounmap((char *)dev->base_addr);
> +       pci_release_regions(pdev);
> 
>         pci_set_drvdata(pdev, NULL);
> +       kfree(dev);

no problem with the patch, this comment is wrong though.  kfree frees
np.

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
