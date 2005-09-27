Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965172AbVI0Vuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbVI0Vuo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 17:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbVI0Vuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 17:50:44 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:4319 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965172AbVI0Vun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 17:50:43 -0400
Date: Tue, 27 Sep 2005 14:50:37 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Jay Lan <jlan@engr.sgi.com>
cc: Hugh Dickins <hugh@veritas.com>,
       Frank van Maarseveen <frankvm@frankvm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
In-Reply-To: <4339BDF6.3070706@engr.sgi.com>
Message-ID: <Pine.LNX.4.62.0509271449280.10674@schroedinger.engr.sgi.com>
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com>
 <43319111.1050803@engr.sgi.com> <Pine.LNX.4.61.0509211802150.8880@goblin.wat.veritas.com>
 <4331990A.80904@engr.sgi.com> <Pine.LNX.4.61.0509211835190.9340@goblin.wat.veritas.com>
 <4331A0DA.5030801@engr.sgi.com> <20050921182627.GB17272@janus>
 <Pine.LNX.4.61.0509211958410.10449@goblin.wat.veritas.com>
 <4339AED4.8030108@engr.sgi.com> <4339BDF6.3070706@engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2005, Jay Lan wrote:

> Just looked at the __vm_stat_account() code. It is enclosed inside
> #ifdef CONFIG_PROC_FS.
> 
> If that is necessary, i can not put hiwater_vm update code in there. The
> system accounting code should not be dependent on a config flag that has
> nothing to do with system accounting.

I doubt you can do accounting without having /proc. Dont you need to 
read/write files in /proc? Can we make accounting dependent on /proc?
