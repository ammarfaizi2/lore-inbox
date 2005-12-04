Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbVLFPh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbVLFPh3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 10:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbVLFPh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 10:37:29 -0500
Received: from [81.2.110.250] ([81.2.110.250]:27339 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750716AbVLFPh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 10:37:28 -0500
Subject: Re: [Lse-tech] Re: [PATCH 0/7]: Fix for unsafe notifier chain
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Keith Owens <kaos@sgi.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>, paulmck@us.ibm.com,
       greg@kroah.com, sekharan@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, Douglas_Warzecha@dell.com,
       Abhay_Salunke@dell.com, achim_leubner@adaptec.com,
       dmp@davidmpye.dyndns.org
In-Reply-To: <4544.1133166696@ocs3.ocs.com.au>
References: <4544.1133166696@ocs3.ocs.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 04 Dec 2005 16:19:57 +0000
Message-Id: <1133713198.3168.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-11-28 at 19:31 +1100, Keith Owens wrote:
> >Or just don't unregister. That is what I did for the debug notifiers.
> 
> Unregister is not the only problem.  Chain traversal races with
> register as well.

There are some NMI handler registration functions and attempts at safe
code for it in the unmerged experimental part of the bluesmoke
(bluesmoke.sf.net) project that may be useful perhaps ?

