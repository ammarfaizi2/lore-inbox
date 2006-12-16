Return-Path: <linux-kernel-owner+w=401wt.eu-S1422801AbWLPXZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422801AbWLPXZc (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 18:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422802AbWLPXZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 18:25:32 -0500
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:39881 "EHLO
	extu-mxob-1.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422801AbWLPXZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 18:25:31 -0500
X-Greylist: delayed 1043 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Dec 2006 18:25:31 EST
X-AuditID: d80ac21c-98b9cbb0000069a0-88-45847c58cba1 
Date: Sat, 16 Dec 2006 23:08:24 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Martin Michlmayr <tbm@cyrius.com>,
       Marc Haber <mh+linux-kernel@zugschlus.de>, Jan Kara <jack@suse.cz>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <1166304581.10372.18.camel@twins>
Message-ID: <Pine.LNX.4.64.0612162259510.15520@blonde.wat.veritas.com>
References: <20061207155740.GC1434@torres.l21.ma.zugschlus.de> 
 <4578465D.7030104@cfl.rr.com>  <20061209092639.GA15443@torres.l21.ma.zugschlus.de>
  <20061216184310.GA891@unjust.cyrius.com>  <Pine.LNX.4.64.0612161909460.25272@blonde.wat.veritas.com>
 <1166304581.10372.18.camel@twins>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 16 Dec 2006 23:08:07.0802 (UTC) FILETIME=[0C7A05A0:01C72167]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2006, Peter Zijlstra wrote:
> Moving the cleaning of the page out from under the private_lock opened
> up a window where newly attached buffer might still see the page dirty
> status and were thus marked (incorrectly) dirty themselves; resulting in
> filesystem data corruption.

I'm not going to pretend to understand the buffers issues here:
people thought that change was safe originally, and I can't say
it's not - it just stood out as a potentially weakening change.

The patch you propose certainly looks like a good way out, if
that moved unlock really is a problem: your patch is very well
worth trying by those people seeing their corruption problems,
let's wait to hear their feedback.

Thanks!
Hugh
