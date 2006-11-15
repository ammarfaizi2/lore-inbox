Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030700AbWKOQy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030700AbWKOQy7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030704AbWKOQy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:54:59 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:49059 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030700AbWKOQy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:54:58 -0500
Date: Wed, 15 Nov 2006 08:54:44 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/28] readahead: state based method - aging accounting
In-Reply-To: <363577024.21908@ustc.edu.cn>
Message-ID: <Pine.LNX.4.64.0611150853510.19227@schroedinger.engr.sgi.com>
References: <20061115075007.832957580@localhost.localdomain>
 <363577024.21908@ustc.edu.cn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006, Wu Fengguang wrote:

> Collect info about the global available memory and its consumption speed.
> The data are used by the stateful method to estimate the thrashing threshold.

Looks like you should use a ZVC counter for total scanned. See 
include/linux/mmzone.h.
