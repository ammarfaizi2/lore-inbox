Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292339AbSCIBig>; Fri, 8 Mar 2002 20:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292338AbSCIBi0>; Fri, 8 Mar 2002 20:38:26 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:6138 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S292336AbSCIBiQ>; Fri, 8 Mar 2002 20:38:16 -0500
Message-ID: <3C896773.15325802@didntduck.org>
Date: Fri, 08 Mar 2002 20:37:55 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Thomas Hood <jdthood@mail.com>, linux-kernel@vger.kernel.org
Subject: Re: PnP BIOS driver status
In-Reply-To: <E16jVbi-0008Gb-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > The current driver is not SMP-safe.  It is modifying the GDT descriptors
> > outside of the pnp_bios_lock.  Also, you can remove the __cli(), as
> > spin_lock_irq() already turns off interrupts.
> 
> The GDT descriptors are private to the PNP BIOS and constant values once
> set up. No PnPBIOS call is made before the configuration is done.
> 
> Seems ok to me - or am I missing something ?

Two user processes calling functions through /proc...

-- 

						Brian Gerst
