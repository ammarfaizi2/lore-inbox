Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262508AbVCJKbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbVCJKbE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 05:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbVCJKbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 05:31:04 -0500
Received: from gate.in-addr.de ([212.8.193.158]:59881 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S262510AbVCJK2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 05:28:24 -0500
Date: Thu, 10 Mar 2005 11:27:26 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Alex Aizman <itn780@yahoo.com>
Cc: Matt Mackall <mpm@selenic.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE 0/6] Open-iSCSI High-Performance Initiator for Linux
Message-ID: <20050310102726.GT4105@marowsky-bree.de>
References: <422BFCB2.6080309@yahoo.com> <20050309050434.GT3163@waste.org> <422E8EEB.7090209@yahoo.com> <20050309060544.GW3120@waste.org> <422E96D9.6090202@yahoo.com> <20050309222114.GF4105@marowsky-bree.de> <422FB2B5.3070803@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <422FB2B5.3070803@yahoo.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-03-09T18:36:37, Alex Aizman <itn780@yahoo.com> wrote:

> Heartbeat is good for reliability, etc. WRT "getting paged-out" - 
> non-deterministic (things depend on time), right?

Right, if we didn't get scheduled often enough for us to send our
heartbeat messages to the other peers, they'll evict us from the cluster
and fence us, causing a service disruption.

With all these protections in place though, we can run at roughly 50ms
heartbeat intervals from user-space, reliably, which allows us a node
dead timer of ~200ms. I think that's pretty damn good.

(Of course, realistically, even for subsecond fail-over, 200ms keep
alives are sufficient, and 50ms would be quite extreme. But, it works.)

> >That works well in our current development series, and if you want to
> >share code, you can either rip it off (Open Source, we love ya ;) or we
> >can spin off these parts into a sub-package for you to depend on...
> If it's not a big deal :-) let's do the "sub-package" option.

I've brought this up on the linux-ha-dev list. When do you need this?


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

