Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271888AbRHUXKY>; Tue, 21 Aug 2001 19:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271890AbRHUXKO>; Tue, 21 Aug 2001 19:10:14 -0400
Received: from p054.as-l031.contactel.cz ([212.65.234.246]:9220 "EHLO
	p054.as-l031.contactel.cz") by vger.kernel.org with ESMTP
	id <S271888AbRHUXJz>; Tue, 21 Aug 2001 19:09:55 -0400
Date: Wed, 22 Aug 2001 01:06:51 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: kees <kees@schoen.nl>
Cc: Alexandre Hautequest <hquest@fesppr.br>, linux-kernel@vger.kernel.org
Subject: Re: IPX in 2.4.[5-9]
Message-ID: <20010822010651.C1074@ppc.vc.cvut.cz>
In-Reply-To: <20010821014517.G1394@ppc.vc.cvut.cz> <Pine.LNX.4.33.0108211436340.29582-100000@schoen3.schoen.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0108211436340.29582-100000@schoen3.schoen.nl>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2001 at 02:38:04PM +0200, kees wrote:
> Hi Petr,
> 
> While slist from 2.2.18 does indeed work with nwserv , nwuserlist does
> not. it returns:
> 
> schoen3:/user2/download/www/ncpfs-2.2.0.18 # util/nwuserlist
> util/nwuserlist: Unknown server (0x89FC) when initializing
> 
> schoen3:/user2/download/www/ncpfs-2.2.0.18 # util/slist
> 
> Known NetWare File Servers                          Network   Node Address
> --------------------------------------------------------------------------
> NW_SCHOEN                                           C0A80A28  000000000001

It is by definition that way. 'slist' does not accept user name,
and lists all available IPX servers on the network, while all other
utilities require some server and user name, and works with specified 
server only. You can specify default server name and user name in ~/.nwclient 
file (man 5 nwclient), if you are lazy to type it.
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz

P.S.: ncpfs is NOT tested with MarS
P.P.S.: I assume that you did all tests with "export LD_LIBRARY_PATH=/user2/
download/www/ncpfs-2.2.0.18/lib", otherwise tools used old system libncp
anyway.

