Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbTDOLqZ (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 07:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbTDOLqY 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 07:46:24 -0400
Received: from smtp1.wanadoo.fr ([193.252.22.25]:61826 "EHLO
	mwinf0604.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261177AbTDOLqY (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 07:46:24 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: BUGed to death
Date: Tue, 15 Apr 2003 13:57:32 +0200
User-Agent: KMail/1.5.1
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <80690000.1050351598@flay> <200304142310.05110.baldrick@wanadoo.fr> <20030414211740.GB11160@suse.de>
In-Reply-To: <20030414211740.GB11160@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304151357.32819.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Right, BUG_ON was added later (possibly for the purpose of
> marking unlikely branches).  I see your point now about gcc
> not recognising branches which are going to be unlikely, but
> whether or not it should is questionable IMO.

It is questionable.  Since even in core kernel code there are
many places with
	if (cond)
		BUG();
rather than
	BUG_ON(cond);
it may be worth seeing if converting them makes a difference
(increases code size though).

Ciao,

Duncan.
