Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161112AbVIPHik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161112AbVIPHik (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 03:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbVIPHik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 03:38:40 -0400
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:59087 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S932607AbVIPHii (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Fri, 16 Sep 2005 03:38:38 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17193.3830.498682.626783@gargle.gargle.HOWL>
Date: Thu, 15 Sep 2005 10:04:38 +0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH] per-task-predictive-write-throttling-1
Newsgroups: gmane.linux.kernel
In-Reply-To: <20050914220334.GF4966@opteron.random>
References: <20050914220334.GF4966@opteron.random>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli writes:
 > Hello,
 > 
 > I wrote a patch to try avoiding making dirty about half the ram of the
 > computer when a single task is writing to disk (like during untarring or

Why is that useful? Don't we want (in general) to cache as many dirty
pages as possible in the hope that some of them will be re-dirtied (thus
avoiding additional write) or truncated (avoiding write altogether)?

Nikita.
