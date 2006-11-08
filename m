Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753834AbWKHBzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834AbWKHBzK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 20:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753835AbWKHBzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 20:55:09 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:32227 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1753834AbWKHBzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 20:55:04 -0500
Date: Wed, 8 Nov 2006 10:56:48 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: clameter@sgi.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       stable@kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Fix sys_move_pages when a NULL node list is passed.
Message-Id: <20061108105648.4a149cca.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061103144243.4601ba76.sfr@canb.auug.org.au>
References: <20061103144243.4601ba76.sfr@canb.auug.org.au>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2006 14:42:43 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> +		} else
> +			pm[i].node = 0;	/* anything to not match MAX_NUMNODES */
>  	}
>  	/* End marker */
>  	pm[nr_pages].node = MAX_NUMNODES;

I think node0 is always online...but this should be

pm[i].node = first_online_node; // /* any online node */

maybe.

-Kame

