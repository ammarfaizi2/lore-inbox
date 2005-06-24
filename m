Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263200AbVFXHcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263200AbVFXHcv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 03:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbVFXHcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 03:32:50 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:15295 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263200AbVFXHco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 03:32:44 -0400
To: Ingo Molnar <mingo@elte.hu>
cc: Shailabh Nagar <nagar@watson.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       Hubertus Franke <frankeh@us.ibm.com>, Shailabh Nagar <nagar@us.ibm.com>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [ckrm-tech] Re: [patch 02/38] CKRM e18: Processor Delay Accounting 
In-reply-to: Your message of Fri, 24 Jun 2005 09:20:19 +0200.
             <20050624072019.GA7191@elte.hu> 
Date: Fri, 24 Jun 2005 00:32:08 -0700
Message-Id: <E1DlifY-0000SB-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 24 Jun 2005 09:20:19 +0200, Ingo Molnar wrote:
> 
> * Shailabh Nagar <nagar@watson.ibm.com> wrote:
> 
> > Thanks. task_curr is what we needed. Would exporting task_curr be ok 
> > or should we continue to wrap in a separate function ?
> 
> wrapping a non-exported function and then exporting it is not nice at 
> all (it circumvents the non-exported status of that original function).  
> But we can internal-export (EXPORT_GPL) task_curr() itself.
> 
> 	Ingo

That would work for us - this is a GPL'd module directed towards
mainline.  No licensing issues to worry about.

gerrit
