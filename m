Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287697AbSABOrZ>; Wed, 2 Jan 2002 09:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287823AbSABOrP>; Wed, 2 Jan 2002 09:47:15 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:5133 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S287697AbSABOrM>;
	Wed, 2 Jan 2002 09:47:12 -0500
Date: Wed, 2 Jan 2002 06:46:10 -0800
From: Greg KH <greg@kroah.com>
To: Raghavendra Koushik <raghavendra.koushik@wipro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hot swap support in linux?
Message-ID: <20020102064610.J27118@kroah.com>
In-Reply-To: <E16LLva-0008AG-00@the-village.bc.nu> <005501c19384$d7fca730$5408720a@M3NOR67026>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005501c19384$d7fca730$5408720a@M3NOR67026>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 05 Dec 2001 11:36:26 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 05:28:50PM +0530, Raghavendra Koushik wrote:
> few more questions pertaining to hot swap..
> 1. 	how exactly do I build my linux kernel with hotswap support. When I do
> 	'make xconfig' (for linux 2.4.4 kernel) I don't see a hotplug option.

The PCI Hotplug code is not in the 2.4.4 kernel.  It went in around
2.4.16 or so.

> 2.	If I write my driver according to the new way of writing PCI drivers for
>     	ethernet cards i.e using MODULE_DEVICE_TABLE et al, is it enough
>     	to make my driver hot pluggable.

Yes.

> 3.	Does the NIC need to provide any particular h/w support to make it
> 	hotpluggable.

No.  The pci hotplug stuff is handled by a separate controller that
handles the initialization and shutdown of the individual PCI cards.

Hope this helps,

greg k-h
