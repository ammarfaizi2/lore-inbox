Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262742AbREVTgT>; Tue, 22 May 2001 15:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262745AbREVTf7>; Tue, 22 May 2001 15:35:59 -0400
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:55575 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S262742AbREVTfv>; Tue, 22 May 2001 15:35:51 -0400
Date: Tue, 22 May 2001 14:35:42 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Dax Kelson <dax@gurulabs.com>, linux-kernel@vger.kernel.org
Subject: Re: Xircom RealPort versus 3COM 3C3FEM656C
In-Reply-To: <E152HYH-0002LB-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1010522143239.29188A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2001, Alan Cox wrote:

> > I currently have three Xircom RealPort Carbus modem/fast ethernet cards.
> > The current driver blows major chunks (it has very poor performance, and
> > stops working under load).  I'm told the driver issues are because of
> > hardware issues. The really nice feature of this card is the form factor
> > though.
> 
> Before you give up on the xircom thing, try the -ac kernel and set the box
> up to use xircom_cb not xircom_tulip_cb
> 
> That might help a lot

Note that the reason why xircom_cb for all cases is that it sets the
card into promisc mode, in all cases.  This punishes your CPU and laptop
battery on a loaded network.

Promisc mode is required because (AFAIK) Xircoms under the same PCI id
can use any one of three setup frame formats, and only one format is
known.

So, you are right, xircom_cb will help a lot in most cases, but the
hardware sucks.  I recommend avoiding it...

	Jeff


P.S. If anybody knows Xircom engineers, we would love a tech contact...

