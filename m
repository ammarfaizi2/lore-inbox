Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129697AbQLUXab>; Thu, 21 Dec 2000 18:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131521AbQLUXaW>; Thu, 21 Dec 2000 18:30:22 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:11853
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129697AbQLUXaK>; Thu, 21 Dec 2000 18:30:10 -0500
Date: Thu, 21 Dec 2000 23:59:37 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cleanup (PCI API and general) of drivers/net/rcpci.c (240t13p3)
Message-ID: <20001221235937.F611@jaquet.dk>
In-Reply-To: <20001221233805.E611@jaquet.dk> <E149EUA-0003iN-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <E149EUA-0003iN-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Dec 21, 2000 at 10:46:52PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2000 at 10:46:52PM +0000, Alan Cox wrote:
> > o The driver currently allocates irqs during its initialization
> >   instead of postponing it until it is opened for use. Is there
> >   a reason for this?
> 
> Shouldnt be - its an I2O network interface with some extra bits for
> the cryptoconfig

OK. I'll move the resource de-/allocation to the open/close call then 
and post a new patch in a few days.
-- 
        Rasmus(rasmus@jaquet.dk)

Gates' Law: Every 18 months, the speed of software halves
  -- Anonymous
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
