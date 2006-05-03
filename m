Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWECXjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWECXjR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 19:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWECXjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 19:39:16 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:11722 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1751399AbWECXjQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 19:39:16 -0400
Date: Thu, 4 May 2006 01:35:58 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: David Vrabel <dvrabel@cantab.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, david@pleyades.net
Subject: Re: [PATCH 2/2] ipg: redundancy with mii.h
Message-ID: <20060503233558.GA27232@electric-eye.fr.zoreil.com>
References: <1146342905.11271.3.camel@localhost> <1146389171.11524.1.camel@localhost> <44554ADE.8030200@cantab.net> <4455F1D8.5030102@cantab.net> <1146506939.23931.2.camel@localhost> <20060501231206.GD7419@electric-eye.fr.zoreil.com> <Pine.LNX.4.58.0605020945010.4066@sbz-30.cs.Helsinki.FI> <20060502214520.GC26357@electric-eye.fr.zoreil.com> <20060502215559.GA1119@electric-eye.fr.zoreil.com> <Pine.LNX.4.58.0605030913210.6032@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0605030913210.6032@sbz-30.cs.Helsinki.FI>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg <penberg@cs.Helsinki.FI> :
[...]
> maintain the tree, I can send you my patches so you can recreate the full 
> history. The first steps were produced by quilt on the original 
> out-of-tree driver, though, so they're probably not helpful.

It will be welcome.

I have added a few little things (changelog below). Next step will
probably be some mii/ethtool stuff.

The branch 'netdev-ipg' is available at:
git://electric-eye.fr.zoreil.com/home/romieu/linux-2.6.git.

Serie of patches (ala 'git format-patch'):
http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.17-rc3/ip1000a/

All-in-one patch:
http://www.fr.zoreil.com/people/francois/misc/20060504-2.6.17-rc3-git-ip1000-test.patch

ChangeLog from yesterday version:

commit 8b0a8db32d1ac6e9bc23300a6a0533b4d7e251e3
Author: Francois Romieu <romieu@fr.zoreil.com>
Date:   Thu May 4 00:29:59 2006 +0200

    ipg: remove forward declarations
    
    It makes no sense in a new driver.
    
    Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

commit 65940e5e0ab88d92fbac0f96b5d46ddfbd5cfa93
Author: Francois Romieu <romieu@fr.zoreil.com>
Date:   Thu May 4 00:04:57 2006 +0200

    ipg: replace #define with enum
    
    Added some underscores to improve readability.
    
    Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

commit ab87a106690d6eaba4b7426fb074270e2e503e40
Author: Francois Romieu <romieu@fr.zoreil.com>
Date:   Wed May 3 22:51:16 2006 +0200

    ipg: removal of useless #defines
    
    IPG_TX_NOTBUSY apart (one occurence in ipg.c), the #defines appear
    nowhere in the sources.
    
    Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

commit ef7bfd886bc436d14649e962edb6f5189cc4dcac
Author: Francois Romieu <romieu@fr.zoreil.com>
Date:   Wed May 3 22:44:47 2006 +0200

    ipg: redundancy with mii.h - take II
    
    Replace a bunch of #define with their counterpart from mii.h
    
    It is applied to the usual MII registers this time.
    
    Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

-- 
Ueimor
