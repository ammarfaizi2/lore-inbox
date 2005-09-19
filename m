Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbVISHKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbVISHKp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 03:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVISHKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 03:10:45 -0400
Received: from noname.neutralserver.com ([70.84.186.210]:41169 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S932346AbVISHKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 03:10:44 -0400
Date: Mon, 19 Sep 2005 10:13:58 +0300
From: Dan Aloni <da-x@monatomic.org>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: workaround large MTU and N-order allocation failures
Message-ID: <20050919071358.GA7107@localdomain>
References: <20050918143526.GA24181@localdomain> <20050918230822.GA5440@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050918230822.GA5440@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.5.10i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 01:08:22AM +0200, Francois Romieu wrote:
> Dan Aloni <da-x@monatomic.org> :
> [...]
> > The problem with large MTU is external memory fragmentation in
> > the buddy system following high workload, causing alloc_skb() to 
> > fail.
> 
> If the issue hits the Rx path, it is probably the responsibility of
> the device driver. Which kind of hardware do you use ?

We are using a SuperMicro board and the network driver is e1000. The
revision of the chipset is 82546GB-copper (maps to e1000_82546_rev_3).

This particular chipset does not support packet splitting, so we
are looking for a hack on the skb layer.

-- 
Dan Aloni
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net
