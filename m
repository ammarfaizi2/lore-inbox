Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277008AbRJCWHb>; Wed, 3 Oct 2001 18:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277009AbRJCWHV>; Wed, 3 Oct 2001 18:07:21 -0400
Received: from ppp36.ts2.Gloucester.visi.net ([209.96.247.100]:42232 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S277008AbRJCWHL>; Wed, 3 Oct 2001 18:07:11 -0400
Date: Wed, 3 Oct 2001 18:03:54 -0400
From: Ben Collins <bcollins@debian.org>
To: Linux Bigot <linuxopinion@yahoo.com>
Cc: Kurt Ferreira <kferreir@esscom.com>, linux-kernel@vger.kernel.org
Subject: Re: how to get virtual address from dma address
Message-ID: <20011003180354.I319@visi.net>
In-Reply-To: <Pine.LNX.4.21.0110031525370.14852-100000@pogo.esscom.com> <20011003214858.97073.qmail@web14807.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011003214858.97073.qmail@web14807.mail.yahoo.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2001 at 02:48:58PM -0700, Linux Bigot wrote:
> oops! I am sorry. I did not meant "pci_unmap_single"
> pci_unmap_single.
> 
> I meant to get a routine which does exactly opposite
> of what pci_map_single does, i.e., give me a virtual
> address for a dma address.

pci_unmap_single is the exact opposite of pci_map_single. It unmaps a
memory region. It just doesn't do what you want.

Bottom line, to keep your driver portable, you are going to have to keep
a mapping of the dma and real addresses either in a structure as most
drivers do, or as a hash like a couple difficult ones do.


Ben

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
