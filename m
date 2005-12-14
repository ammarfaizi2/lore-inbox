Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbVLNJWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbVLNJWd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 04:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbVLNJWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 04:22:32 -0500
Received: from ns1.suse.de ([195.135.220.2]:4799 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932243AbVLNJWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 04:22:32 -0500
Date: Wed, 14 Dec 2005 10:22:28 +0100
From: Andi Kleen <ak@suse.de>
To: Sridhar Samudrala <sri@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
Message-ID: <20051214092228.GC18862@brahms.suse.de>
References: <Pine.LNX.4.58.0512140042280.31720@w-sridhar.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0512140042280.31720@w-sridhar.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would appreciate any feedback or comments on this approach.

Maybe I'm missing something but wouldn't you need an own critical
pool (or at least reservation) for each socket to be safe against deadlocks?

Otherwise if a critical sockets needs e.g. 2 pages to finish something
and 2 critical sockets are active they can each steal the last pages
from each other and deadlock.

-Andi
