Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317656AbSFLHUj>; Wed, 12 Jun 2002 03:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317661AbSFLHUi>; Wed, 12 Jun 2002 03:20:38 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29188 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317656AbSFLHUh>; Wed, 12 Jun 2002 03:20:37 -0400
Subject: Re: 2.4.18 no timestamp update on modified mmapped files
To: hugh@veritas.com (Hugh Dickins)
Date: Wed, 12 Jun 2002 08:40:54 +0100 (BST)
Cc: akpm@zip.com.au (Andrew Morton), kaos@ocs.com.au (Keith Owens),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0206111006300.1028-100000@localhost.localdomain> from "Hugh Dickins" at Jun 11, 2002 10:10:28 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17I2kQ-000757-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 11 Jun 2002, Andrew Morton wrote:
> > 
> > I think it's too late to fix this in 2.4.  If we did, a person
> > could develop and test an application on 2.4.21, ship it, then
> > find that it fails on millions of 2.4.17 machines.
> 
> Oh, please reconsider that!  Doesn't loss of modification time
> approach data loss?  Surely we'll continue to fix any data loss
> issues in 2.4, and be grateful if you fixed this mmap modtime loss.

It doesnt approach data loss, when doing incremental backups it
*is* data loss. Ditto with rsync --newer
