Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVCIFEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVCIFEq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 00:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVCIFEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 00:04:45 -0500
Received: from waste.org ([216.27.176.166]:39601 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261168AbVCIFEg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 00:04:36 -0500
Date: Tue, 8 Mar 2005 21:04:35 -0800
From: Matt Mackall <mpm@selenic.com>
To: Alex Aizman <itn780@yahoo.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE 0/6] Open-iSCSI High-Performance Initiator for Linux
Message-ID: <20050309050434.GT3163@waste.org>
References: <422BFCB2.6080309@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422BFCB2.6080309@yahoo.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 11:03:14PM -0800, Alex Aizman wrote:
> As far as user/kernel, the existing iSCSI initiators bloat the kernel with
> ever-growing control plane code, including but not limited to: iSCSI
> discovery, Login (Authentication and Operational), session and connection
> management, connection-level error processing, iSCSI Text, Nop-Out/In, Async
> Message, iSNS, SLP, Radius... Open-iSCSI puts the entire control plane in
> the user space. This control plane talks to the data plane via well defined
> interface over the netlink transport.

How big is the userspace client?

How does this perform under memory pressure? If the userspace iSCSI
client is paged out for whatever reason, and flushing _to_ an iSCSI
device is necessary to page the usersace portion back in, and the
connection needs restarting or the like to flush... 
 
> Performance.
> This is the major goal and motivation for this project. As it happens, iSCSI
> has to compete with Fibre Channel, which is a more entrenched technology in
> the storage space. In addition, the "soft" iSCSI implementation have to show
> good results in presence of specialized hardware offloads.
> 
> Our today's performance numbers are:
> 
> - 450MB/sec Read on a single connection (2-way 2.4Ghz Opteron, 64KB block 
> size);

With what network hardware and drives, please?

-- 
Mathematics is the supreme nostalgia of our time.
