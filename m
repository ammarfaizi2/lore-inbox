Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293126AbSBWMO4>; Sat, 23 Feb 2002 07:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293127AbSBWMOq>; Sat, 23 Feb 2002 07:14:46 -0500
Received: from sproxy.gmx.net ([213.165.64.20]:42763 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S293126AbSBWMOe>;
	Sat, 23 Feb 2002 07:14:34 -0500
Message-ID: <3C778797.3BC039A@gmx.net>
Date: Sat, 23 Feb 2002 13:14:15 +0100
From: Gunther Mayer <gunther.mayer@gmx.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linuxdiskcert.org>
CC: Adam Huffman <bloch@verdurin.com>, linux-kernel@vger.kernel.org
Subject: Re: Boot problem with PDC20269
In-Reply-To: <Pine.LNX.4.10.10202221953470.3281-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:

> Hi Adam,
>
> http://www.tecchannel.de/hardware/817/index.html
>
> We do not put ATAPI devices on such HOSTS.

put == support ?

>
> The driver will not work w/ ATAPI there because it uses a different DMA
> engine location and is not supported in Linux.

It is a serious bug in the IDE driver to hang the system (and not the user's
fault).

A fix would be to printk("The linux IDE driver does not (yet?)support ATAPI
devices on PDC20269. Ignoring the device.\n");
and continue running.

-
Gunther




