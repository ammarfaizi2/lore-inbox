Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262861AbVA2GMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbVA2GMM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 01:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262863AbVA2GMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 01:12:12 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:32815 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262861AbVA2GMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 01:12:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=CVgOdV56w7ozmLDAXBA0PV2p2fTFc52LstRgH+UFivA5UVDDXeqBkjZ9cyoY9ZmdxvjlF1Dqe7UMJfLH7+R69oourysKvRdMw5gdvhJkuPhkbQQdCNIuY09iDoTSIzsHigYg8+xAgbO6pDNF9AmYzWQ4cS9xBazCT57WsMkvWCo=
Message-ID: <2ec2c15a050128221279a11585@mail.gmail.com>
Date: Fri, 28 Jan 2005 22:12:04 -0800
From: Prashant Viswanathan <vprashant@gmail.com>
Reply-To: Prashant Viswanathan <vprashant@gmail.com>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: Compactflash (Sandisk 512) hangs on access
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050127210735.GS7048@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <2ec2c15a05012710356feafc81@mail.gmail.com>
	 <20050127210735.GS7048@alpha.home.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I have been trying unsuccessfully over the last 2 weeks to get
> > compactflash working on my Linux system based on mini-ITX (Via CL
> > motherboard, pentium compatible).
> >
> > I use a CF->IDE adapter to access it just like a IDE hard disk. My
> > compactflash is Sandisk SDCFH-512. Linux can detect it. I can even
> > mount it and do a fdisk on it. However, the moment I try to do
> > anything substantial like copy multiple files or copy 1000 blocks
> > using dd, I lose access to it. Linux loses access to it totally. I
> > can't even do a fdisk on it. I get an error like "Unable to open
> > /dev/hdc".


On Thu, 27 Jan 2005 22:07:35 +0100, Willy Tarreau <willy@w.ods.org> wrote:
> Have you checked that the power connector really provides 5V to the
> IDE-CF adapter ? I had the exact same behaviour 5 years ago with a power
> wire cut. Signal lines were powerful enough to bring power to the cheap
> flash (16 MB), I could even read it, most times. The kernel almost always
> booted from it, and when it turned to mount the ext2 fs R/W, it hanged. I
> finally partially destroyed it this way, and it got several defects which
> could not be cleaned with a simple write or format.
> 
> Other than that, I have lots of CF cards on IDE adapters (some on motherboard,
> some hand-made, some bought to serious makers), and never ran into such
> problems since.
> 
> Willy

The power connector is fine.

I also disabled DMA (some suggestion on this newsgroup to a similar
error) and now I can't turn it back on.

<snip>
everest root # hdparm -d1 /dev/hdc

/dev/hdc:
setting using_dma to 1 (on)
