Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262879AbUKXWqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262879AbUKXWqR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 17:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbUKXWqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 17:46:17 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10937 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262872AbUKXWqP (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 17:46:15 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16805.752.136395.85463@gargle.gargle.HOWL>
Date: Thu, 25 Nov 2004 00:53:52 +0300
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Andrew Morton <AKPM@Osdl.ORG>,
       Linux MM Mailing List <linux-mm@kvack.org>
Subject: Re: [PATCH]: 1/4 batch mark_page_accessed()
In-Reply-To: <20041124163216.GB11432@logos.cnet>
References: <16800.47044.75874.56255@gargle.gargle.HOWL>
	<20041124163216.GB11432@logos.cnet>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti writes:
 > 
 > Hi Nikita,

Hello, Marcelo,

 > 

[...]

 > > +		if (pagezone != zone) {
 > > +			if (zone)
 > > +				local_unlock_irq(&zone->lru_lock);
 > 
 > You surely meant spin_{un}lock_irq and not local{un}lock_irq.

Oh, you are right. local_lock_* are functions to manipulate "local wait"
spin-lock variety that was introduced by some other
patch. batch-mark_page_accessed patch worked only because all references
to local_lock_* functions were removed by pvec-cleanup patch.

Another proof of the obvious fact that manually coded pagevec iteration
is evil. :)

 > 
 > Started the STP tests on 4way/8way boxes.

Great.

Nikita.
