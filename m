Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268890AbUIHG6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268890AbUIHG6f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 02:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268900AbUIHG6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 02:58:19 -0400
Received: from cantor.suse.de ([195.135.220.2]:13199 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268890AbUIHGzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 02:55:49 -0400
Date: Wed, 8 Sep 2004 08:55:48 +0200
From: Andi Kleen <ak@suse.de>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] f_ops flag to speed up compatible ioctls in linux kernel
Message-ID: <20040908065548.GE27886@wotan.suse.de>
References: <20040907121418.GC25051@wotan.suse.de> <20040907134517.GA1016@mellanox.co.il> <20040907141524.GA13862@wotan.suse.de> <20040907142530.GB1016@mellanox.co.il> <20040907142945.GB20981@wotan.suse.de> <20040907143702.GC1016@mellanox.co.il> <20040907144452.GC20981@wotan.suse.de> <20040907144543.GA1340@mellanox.co.il> <20040907151022.GA32287@wotan.suse.de> <20040907181641.GB2154@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907181641.GB2154@mellanox.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wait, I think that a properly coded ioctl can always
> figure out this is a compat call by looking at the command
> (see example below).
> So maybe we can live with just one new entry point with these
> semantics?

I think two is cleaner. And needing 8 bytes more for a file_operations
structure is not exactly a catastrophe.

-Andi
