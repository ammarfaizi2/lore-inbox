Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266197AbVBDUog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266197AbVBDUog (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 15:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263291AbVBDUgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 15:36:03 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:41882 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S265857AbVBDU0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 15:26:07 -0500
Date: Fri, 4 Feb 2005 21:26:28 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: Rahul Jain <rbj2@oak.njit.edu>
Subject: Re: How to add source files in kernel
Message-ID: <20050204202628.GA14973@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0502041408540.12006@chrome.njit.edu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rahul Jain <rbj2@oak.njit.edu> ha scritto:
> The kernel recompilation went without any problems. I wrote loadable
> module programs that can access the functions defined in .c. When I try to
> install these modules, they came back with the following error
> 
> /sbin/insmod x.o
> x.o: unresolved symbol enqueue_sfi
> x.o: unresolved symbol init_skbuff_list
> x.o: unresolved symbol get_head_sfi
> x.o: unresolved symbol search_sfi
> x.o: unresolved symbol enqueue_skbuff_list
> x.o: unresolved symbol init_head_sfi
> x.o:
> Hint: You are trying to load a module without a GPL compatible license
>      and it has unresolved symbols.  Contact the module supplier for
>      assistance, only they can help you.
> 
> make: *** [install] Error 1

You forgot the EXPORT for those symbols, add:

EXPORT_SYMBOL(symbol_name);

to .c file. Or you may have exported the symbols as GPL only
(EXPORT_SYMBOL_GPL) and the module which is not licensed under GPL
cannot see them.

Luca
-- 
Home: http://kronoz.cjb.net
La somma dell'intelligenza sulla terra e` una costante.
La popolazione e` in aumento.
