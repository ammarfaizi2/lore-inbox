Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135174AbRDZW7y>; Thu, 26 Apr 2001 18:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135247AbRDZW7o>; Thu, 26 Apr 2001 18:59:44 -0400
Received: from [209.250.53.156] ([209.250.53.156]:18180 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S135174AbRDZW70>; Thu, 26 Apr 2001 18:59:26 -0400
Date: Thu, 26 Apr 2001 17:59:07 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.4.4.7: serial PCI fixes and cleanup
Message-ID: <20010426175907.A673@hapablap.dyn.dhs.org>
In-Reply-To: <3AE80BAC.494F096B@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AE80BAC.494F096B@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Apr 26, 2001 at 07:51:08AM -0400
X-Uptime: 5:58pm  up 9 min,  1 user,  load average: 1.31, 1.18, 0.64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a heads up:  works great for me

On Thu, Apr 26, 2001 at 07:51:08AM -0400, Jeff Garzik wrote:
> The attached patch, against 2.4.4-pre7, cleans up the huge pci_board
> list in serial.c to remove PCI id information.  In the process, it (a)
> demonstrates more complex new-style PCI probing, and (b) fixes a logical
> disconnect bug which was causing bug reports.  The bug caused by me,
> when I added hotplugging to the serial driver (merging serial_cb in
> function, but not literally).  The bug causes any PCI board which is
> listed in the serial.c PCI table, but was not
> PCI_CLASS_COMMUNICATION_SERIAL or PCI_CLASS_COMMUNICATION_MODEM, to be
> missed in the PCI probe.
> 
> Linus - do not apply just yet.  I would prefer this patch go into 2.4.5
> not 2.4.4, so that we can have a bit more public testing first.
> tytso - a quick eyeball would be awesome.  Ask away with any questions
> you have.
> Alan - please consider applying to your tree.
> Steven - please test, this patch removes the need for your serial.c
> patch.
> 
> Others - all testing is welcome.
