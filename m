Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbUDIVvM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 17:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbUDIVvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 17:51:12 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:31395 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261817AbUDIVvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 17:51:07 -0400
Date: Fri, 9 Apr 2004 22:51:03 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
In-Reply-To: <1524892704.1081543162@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0404092247480.5269-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Apr 2004, Martin J. Bligh wrote:
> > This anobjrmap 9 (or anon_mm9) patch adds Rajesh's radix priority search
> > tree on top of Martin's 2.6.5-rc3-mjb2 tree, making a priority mjb tree!
> > Approximately equivalent to Andrea's 2.6.5-aa1, but using anonmm instead
> > of anon_vma, and of course each tree has its own additional features.
> 
> This slows down kernel compile a little, but worse, it slows down SDET
> by about 25% (on the 16x). I think you did something horrible to sem
> contention ... presumably i_shared_sem, which SDET was fighting with
> as it was anyway ;-(
> 
> Diffprofile shows:
> 
>     122626    15.7% total
>      44129   790.0% __down
>      20988     4.1% default_idle

Many thanks for the good news, Martin ;)
Looks like I've done something very stupid, perhaps a mismerge.
Not found it yet, I'll carry on looking tomorrow.

Hugh

