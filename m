Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbVD1QqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVD1QqT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 12:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVD1QqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 12:46:18 -0400
Received: from gate.in-addr.de ([212.8.193.158]:44928 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S262168AbVD1QqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 12:46:10 -0400
Date: Thu, 28 Apr 2005 18:45:29 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Daniel McNeil <daniel@osdl.org>
Cc: David Teigland <teigland@redhat.com>, Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1b/7] dlm: core locking
Message-ID: <20050428164529.GF21645@marowsky-bree.de>
References: <20050425165826.GB11938@redhat.com> <1114466097.30427.32.camel@persist.az.mvista.com> <20050426054933.GC12096@redhat.com> <1114537223.31647.10.camel@persist.az.mvista.com> <20050427030217.GA9963@redhat.com> <20050427134142.GZ4431@marowsky-bree.de> <20050427142638.GG16502@redhat.com> <20050428123315.GP21645@marowsky-bree.de> <1114706362.18352.85.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1114706362.18352.85.camel@ibm-c.pdx.osdl.net>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-04-28T09:39:22, Daniel McNeil <daniel@osdl.org> wrote:

> Since a DLM is a distributed lock manager, its usage is entirely for
> locking some shared resource (might not be storage, might be shared
> state, shared data, etc).   If the DLM can grant a lock, but not
> guarantee that other nodes (including the ones that have been kicked
> out of the cluster membership) do not have a conflicting DLM lock, then
> any applications that depend on the DLM for protection/coordination
> be in trouble.  Doesn't the GFS code depend on the DLM not being
> recovered until after fencing of dead nodes?

It makes a whole lot of sense to combine a DLM with (appropriate)
fencing so that the shared resources are protected. I understood David's
comment to rather imply that fencing is assumed to happen outside the
DLM's world in a different component; ie more of a comment on sane
modularization instead of sane real-world configuration.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

