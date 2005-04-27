Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVD0NmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVD0NmA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 09:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVD0Nl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 09:41:59 -0400
Received: from gate.in-addr.de ([212.8.193.158]:52158 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261399AbVD0Nl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 09:41:57 -0400
Date: Wed, 27 Apr 2005 15:23:43 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Mark Fasheh <mark.fasheh@oracle.com>, David Teigland <teigland@redhat.com>
Cc: Wim Coekaerts <wim.coekaerts@oracle.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 0/7] dlm: overview
Message-ID: <20050427132343.GX4431@marowsky-bree.de>
References: <20050425151136.GA6826@redhat.com> <20050425203952.GE25002@ca-server1.us.oracle.com> <20050426053930.GA12096@redhat.com> <20050426184845.GA938@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050426184845.GA938@ca-server1.us.oracle.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-04-26T11:48:45, Mark Fasheh <mark.fasheh@oracle.com> wrote:

> Resource lookup times, times to deliver events to clients (asts, basts,
> etc) for starters. How long does recovery take after a node crash? How does
> all of this scale as you increase the number of nodes in your cluster?

Well, frankly, recovery time of the DLM mostly will depend on the speed
of the membership algorithm and timings used. My gut feeling is that DLM
recovery time is small compared to membership event detection and the
necessary fencing operation.

But yes, scalability, at least roughly O(foo) guesstimates, for numbers
of locks and/or number of nodes would be helpful, both for a) speed, but
also b) number of network messages involved, for recovery and lock
acquisition.

Mark, do you have the data you ask for for OCFS2's DLM?

(BTW, trimming quotes is considered polite on LKML.)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

