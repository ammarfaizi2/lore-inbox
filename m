Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264493AbTCXWs1>; Mon, 24 Mar 2003 17:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264494AbTCXWs1>; Mon, 24 Mar 2003 17:48:27 -0500
Received: from [81.80.245.157] ([81.80.245.157]:49543 "EHLO smtp.alcove-fr")
	by vger.kernel.org with ESMTP id <S264493AbTCXWs0>;
	Mon, 24 Mar 2003 17:48:26 -0500
Date: Mon, 24 Mar 2003 23:59:26 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Dominik Brodowski <linux@brodo.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       rusty@rustcorp.com.au, torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Subject: Re: [CFT/RFC] pcmcia bus driver as an interface to pcmcia_socket class_type devices [Was: Re: pcmcia_bus_type changes cause oops...]
Message-ID: <20030324225926.GA30604@vitel.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Dominik Brodowski <linux@brodo.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	rusty@rustcorp.com.au, torvalds@transmeta.com,
	alan@lxorguk.ukuu.org.uk
References: <20030324153659.GA32044@hottah.alcove-fr> <20030324162519.GB2194@brodo.de> <20030324163744.GD32044@hottah.alcove-fr> <20030324171703.GA3152@brodo.de> <20030324172548.GG32044@hottah.alcove-fr> <20030324201428.GA6029@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030324201428.GA6029@brodo.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 09:14:28PM +0100, Dominik Brodowski wrote:

> [Stelian: could you try this patch instead of the much smaller one
> sent before, please? Thanks!]

Patch works and reenables modular pcmcia to work. Thanks Dominik !

Except that those recent changes in the pcmcia broke the Red Hat (8.0)
boot scripts. Whether the problem lies in the scripts or the new 
module dependencies is questionable.

The problem comes from the fact that loading ds.o would fail if
a socket driver is not already loaded. In the new kernel it just
wload sucessfuly.

As a side effect of that the interface is recognised as a wireless
one, and the pcmcia starting script finally doesn't load yenta_socket
because , as pcmcia_core is already loaded, it believes it is already
started. But as I said, the script logic is questionable.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
