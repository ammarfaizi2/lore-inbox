Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317266AbSFLLwT>; Wed, 12 Jun 2002 07:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317270AbSFLLwS>; Wed, 12 Jun 2002 07:52:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37328 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317266AbSFLLwR>;
	Wed, 12 Jun 2002 07:52:17 -0400
Date: Wed, 12 Jun 2002 04:47:59 -0700 (PDT)
Message-Id: <20020612.044759.115989376.davem@redhat.com>
To: wjhun@ayrnetworks.com
Cc: paulus@samba.org, roland@topspin.com, linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020610110740.B30336@ayrnetworks.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: William Jhun <wjhun@ayrnetworks.com>
   Date: Mon, 10 Jun 2002 11:07:40 -0700

   On Sun, Jun 09, 2002 at 09:27:05PM -0700, David S. Miller wrote:
   > I'm trying to specify this such that knowledge of cachelines and
   > whatnot don't escape the arch specific code, ho hum...  Looks like
   > that isn't possible.
   
   Perhaps provide macros in asm/pci.h that will:
   
You don't understand, I think.  I want to avoid the drivers doing
any of the "align this, align that" stuff.  I want the allocation
to do it for them, that way the code is in one place.
