Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274148AbRISTlp>; Wed, 19 Sep 2001 15:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274149AbRISTlg>; Wed, 19 Sep 2001 15:41:36 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29715 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274148AbRISTlT>; Wed, 19 Sep 2001 15:41:19 -0400
Subject: Re: broken VM in 2.4.10-pre9
To: phillips@bonn-fries.net (Daniel Phillips)
Date: Wed, 19 Sep 2001 20:45:55 +0100 (BST)
Cc: ebiederm@xmission.com (Eric W. Biederman),
        rfuller@nsisoftware.com (Rob Fuller), linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
In-Reply-To: <20010919093828Z17304-2759+92@humbolt.nl.linux.org> from "Daniel Phillips" at Sep 19, 2001 11:45:44 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jnIB-0003gh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On September 17, 2001 06:03 pm, Eric W. Biederman wrote:
> > In linux we have avoided reverse maps (unlike the BSD's) which tends
> > to make the common case fast at the expense of making it more
> > difficult to handle times when the VM system is under extreme load and
> > we are swapping etc.
> 
> What do you suppose is the cost of the reverse map?  I get the impression you 
> think it's more expensive than it is.

We can keep the typical page table cost lower than now (including reverse
maps) just by doing some common sense small cleanups to get the page struct
down to 48 bytes on x86
