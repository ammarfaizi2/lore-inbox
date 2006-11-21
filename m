Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030801AbWKUKB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030801AbWKUKB4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 05:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030802AbWKUKB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 05:01:56 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:674 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1030801AbWKUKBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 05:01:55 -0500
To: balbir@in.ibm.com
Subject: Re: [RFC][PATCH 5/8] RSS controller task migration support
Cc: ckrm-tech@lists.sourceforge.net, dev@openvz.org, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, rohitseth@google.com
Message-Id: <20061121100150.9ECCF1B6AC@openx4.frec.bull.fr>
Date: Tue, 21 Nov 2006 11:01:50 +0100 (CET)
From: Patrick.Le-Dot@bull.net (Patrick.Le-Dot)
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/11/2006 11:08:56,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/11/2006 11:08:57,
	Serialize complete at 21/11/2006 11:08:57
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006 22:04:08 +0530
> ...
> I am not against guarantees, but
> 
> Consider the following scenario, let's say we implement guarantees
> 
> 1. If we account for kernel resources, how do you provide guarantees
>    when you have non-reclaimable resources?

First, the current patch is based only on pages available in the
struct mm.
I doubt that these pages are "non-reclaimable"...

And guarantee should be ignored just because some kernel resources
are marked "non-reclaimable" ?


> 2. If a customer runs a system with swap turned off (which is quite
>    common),

quite common, really ?

>             then anonymous memory becomes irreclaimable. If a group
>    takes more than it's fair share (exceeds its guarantee), you
>    have scenario similar to 1 above.

That seems to be just a subset of the "guarantee+limit" model : if
guarantee is not useful for you, don't use it.

I'm not saying that guarantee should be a magic piece of code working
for everybody.

But we have to propose something for the customers who ask for a
guarantee (ie using a system with swap turned on like me and this is
quite common:-)

Patrick

+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+    Patrick Le Dot
 mailto: P@trick.Le-Dot@bull.net         Centre UNIX de BULL SAS
 Phone : +33 4 76 29 73 20               1, Rue de Provence     BP 208
 Fax   : +33 4 76 29 76 00               38130 ECHIROLLES Cedex FRANCE
 Bull, Architect of an Open World TM
 www.bull.com
