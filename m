Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVEBVAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVEBVAm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 17:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVEBVAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 17:00:41 -0400
Received: from gate.in-addr.de ([212.8.193.158]:18123 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261771AbVEBVAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 17:00:30 -0400
Date: Mon, 2 May 2005 22:45:14 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Daniel Phillips <phillips@istop.com>
Cc: Daniel McNeil <daniel@osdl.org>, David Teigland <teigland@redhat.com>,
       Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1b/7] dlm: core locking
Message-ID: <20050502204514.GB4722@marowsky-bree.de>
References: <20050425165826.GB11938@redhat.com> <1114706362.18352.85.camel@ibm-c.pdx.osdl.net> <20050428164529.GF21645@marowsky-bree.de> <200504290425.24485.phillips@istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200504290425.24485.phillips@istop.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-04-29T04:25:24, Daniel Phillips <phillips@istop.com> wrote:

> > It makes a whole lot of sense to combine a DLM with (appropriate)
> > fencing so that the shared resources are protected. I understood David's
> > comment to rather imply that fencing is assumed to happen outside the
> > DLM's world in a different component; ie more of a comment on sane
> > modularization instead of sane real-world configuration.
> 
> But just because fencing is supposed to happen in an external component, 
> we can't wave our hands at it and skip the analysis.  We _must_ identify the 
> fencing assumptions and trace the fencing paths with respect to every 
> recovery algorithm in every cluster component, including the dlm.

"A fenced node no longer has access to any shared resource".

Is there any other assumption you have in mind?


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

