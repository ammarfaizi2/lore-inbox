Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUFWVic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUFWVic (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbUFWVgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:36:07 -0400
Received: from holomorphy.com ([207.189.100.168]:27525 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266705AbUFWV3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:29:43 -0400
Date: Wed, 23 Jun 2004 14:29:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: Re: [oom]: [3/4] track wired pages on a per-zone basis
Message-ID: <20040623212940.GD1552@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <0406231407.Wa3a0aIbWaLbXaJbIb1a1aLbKb2aKb2a3aYaJbYa3a1a4aJbKbWa4a0a4a4aWaHb342@holomorphy.com> <0406231407.1a2a3aHb2aIbHbLbHb5a0a5a0aWaJbJbLbIbXaJbLbIbWaKbXa0a4aMbJbHb4aXa342@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0406231407.1a2a3aHb2aIbHbLbHb5a0a5a0aWaJbJbLbIbXaJbLbIbWaKbXa0a4aMbJbHb4aXa342@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 02:07:48PM -0700, William Lee Irwin III wrote:
> +		for (wired = cpu = 0; cpu < NR_CPUS; ++cpu)
> +			wired += zone->nr_wired[cpu];
> +		wired >>= PAGE_SHIFT - 10;
> +		seq_printf(m, "Node %d, zone %8s wired: %lu kB\n",
> +					pgdat->node_id, zone->name, wired);

Should be:
> +		wired <<= PAGE_SHIFT - 10;


-- wli
