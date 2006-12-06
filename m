Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937784AbWLFXUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937784AbWLFXUF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 18:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937786AbWLFXUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 18:20:05 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53683 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S937785AbWLFXUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 18:20:03 -0500
Date: Wed, 6 Dec 2006 23:27:14 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Frank Sorenson <frank@tuxrocks.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Greg KH <greg@kroah.com>
Subject: Re: Kernel panic at boot with recent pci quirks patch
Message-ID: <20061206232714.54ec6f7b@localhost.localdomain>
In-Reply-To: <45771F0B.8090708@tuxrocks.com>
References: <45771F0B.8090708@tuxrocks.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Dec 2006 13:50:35 -0600
Frank Sorenson <frank@tuxrocks.com> wrote:

> The latest -git tree panics at boot for me.  git-bisect traced the offending commit to:
> 
> 368c73d4f689dae0807d0a2aa74c61fd2b9b075f is first bad commit
> commit 368c73d4f689dae0807d0a2aa74c61fd2b9b075f
> Author: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Date:   Wed Oct 4 00:41:26 2006 +0100
> 
>     PCI: quirks: fix the festering mess that claims to handle IDE quirks
> 
> Hardware is a Dell Inspiron E1705 laptop running FC6 x86_64.
> 
> I've attached a netcconsole dump of the panic, as well as lspci output.
> 
> Is there any additional information I can provide?

None needed - there is a patch outstanding for libata which is needed to
go with the PCI updates. Once both hit Linus tree the combined mode
problem you see will vanish. Just quirks went via gregkh pci tree and
libata fixes via libata tree. 


Alan
