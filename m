Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbVKASKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbVKASKl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 13:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVKASKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 13:10:41 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:8393 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751084AbVKASKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 13:10:40 -0500
Date: Tue, 1 Nov 2005 10:10:06 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       marcelo.tosatti@cyclades.com, kravetz@us.ibm.com,
       raybry@mpdtxmail.amd.com, lee.schermerhorn@hp.com,
       linux-kernel@vger.kernel.org, magnus.damm@gmail.com, pj@sgi.com,
       haveblue@us.ibm.com, kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 5/5] Swap Migration V5: sys_migrate_pages interface
In-Reply-To: <Pine.LNX.4.61.0511010658270.31439@chaos.analogic.com>
Message-ID: <Pine.LNX.4.62.0511011009230.16388@schroedinger.engr.sgi.com>
References: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com><20051101031305.12488.1224.sendpatchset@schroedinger.engr.sgi.com>
 <20051031212742.3e43c829.akpm@osdl.org> <Pine.LNX.4.61.0511010658270.31439@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2005, linux-os (Dick Johnson) wrote:

> >> +	 */
> >> +	if ((current->euid ^ task->suid) && (current->euid ^ task->uid) &&
> >> +	    (current->uid ^ task->suid) && (current->uid ^ task->uid) &&
> >
> > Obscure.  Can you please explain the thinking behind putting this check in
> > here?  Preferably via a comment...
> 
> Also XOR is not a good substitute for a compare. Except in some
> strange corner cases, the code will always take more CPU cycles
> because XOR modifies oprands while compares don't need to.

May I submit a patch that removes these strange checks both for 
check_kill_permission and sys_migrate_pages?

