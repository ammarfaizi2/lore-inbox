Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277034AbRJDAYk>; Wed, 3 Oct 2001 20:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277036AbRJDAYa>; Wed, 3 Oct 2001 20:24:30 -0400
Received: from pizda.ninka.net ([216.101.162.242]:62869 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S277034AbRJDAYS>;
	Wed, 3 Oct 2001 20:24:18 -0400
Date: Wed, 03 Oct 2001 17:24:39 -0700 (PDT)
Message-Id: <20011003.172439.66056954.davem@redhat.com>
To: James.Bottomley@HansenPartnership.com
Cc: jes@sunsite.dk, linuxopinion@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: how to get virtual address from dma address
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200110032244.f93MiI103485@localhost.localdomain>
In-Reply-To: <200110032244.f93MiI103485@localhost.localdomain>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: James Bottomley <James.Bottomley@HansenPartnership.com>
   Date: Wed, 03 Oct 2001 17:44:18 -0500

   (although I can see it may be expensive to walk iommu page tables)

I know of hardware where doing the reverse mapping would not even be
possible, the page tables are in hardware registers and are "write
only".  This means you can't even read the PTEs back, you'd have to
keep track of them in software and that is totally unacceptable
overhead when it won't even be used %99 of the time.

The DMA API allows us to support such hardware cleanly and
efficiently, but once we add this feature which "everyone absolutely
needs" we have a problem with the above mentioned piece of hardware.

Franks a lot,
David S. Miller
davem@redhat.com

