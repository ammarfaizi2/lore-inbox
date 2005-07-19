Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVGSQY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVGSQY1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 12:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVGSQY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 12:24:27 -0400
Received: from gate.in-addr.de ([212.8.193.158]:46567 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261541AbVGSQYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 12:24:25 -0400
Date: Tue, 19 Jul 2005 17:52:14 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-cluster@redhat.com, ocfs2-devel@oss.oracle.com
Subject: Re: [Ocfs2-devel] [RFC] nodemanager, ocfs2, dlm
Message-ID: <20050719155214.GG13246@marowsky-bree.de>
References: <20050718061553.GA9568@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050718061553.GA9568@redhat.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-07-18T14:15:53, David Teigland <teigland@redhat.com> wrote:

> Some of the comments about the dlm concerned how it's configured (from
> user space.)  In particular, there was interest in seeing the dlm and
> ocfs2 use common methods for their configuration.
> 
> The first area I'm looking at is how we get addresses/ids of other nodes.
> Currently, the dlm uses an ioctl on a misc device and ocfs2 uses a
> separate kernel module called "ocfs2_nodemanager" that's based on
> configfs.
> 
> I've taken a stab at generalizing ocfs2_nodemanager so the dlm could use
> it (removing ocfs-specific stuff).  It still needs some work, but I'd like
> to know if this appeals to the ocfs group and to others who were
> interested in seeing some similarity in dlm/ocfs configuration.

Hi Dave, I finally found time to read through this.

Yes, I most definetely like where this is going!

> +/* TODO:
> +   - generic addresses (IPV4/6)
> +   - multiple addresses per node

The nodeid, I thought, was relative to a given DLM namespace, no? This
concept seems to be missing here, or are you suggesting the nodeid to be
global across namespaces?

Also, eventually we obviously need to have state for the nodes - up/down
et cetera. I think the node manager also ought to track this.

How would kernel components use this and be notified about changes to
the configuration / membership state?


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

