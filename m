Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266435AbTBCOj0>; Mon, 3 Feb 2003 09:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266438AbTBCOj0>; Mon, 3 Feb 2003 09:39:26 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:29329
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266435AbTBCOjZ>; Mon, 3 Feb 2003 09:39:25 -0500
Subject: Re: PnP model
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Adam Belay <ambx1@neo.rr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "greg@kroah.com" <greg@kroah.com>
In-Reply-To: <Pine.LNX.4.44.0302031437310.1116-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0302031437310.1116-100000@pnote.perex-int.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044287108.20788.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 03 Feb 2003 15:45:09 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-03 at 13:55, Jaroslav Kysela wrote:
> 	I strongly vote to follow the same behaviour as PCI code does:
> It means call the activation / enabling / setting functions from the 
> probe() callbacks. Only the driver knows what's the best. Including 
> the manual assignment of resources.

I agree. A lot of drivers should be able to use one model for everything
including "enable_device" stuff. Right now its all a bit too detailed.

Also the locking model seems very unclear and there are hot swappable ISA
bays

