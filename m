Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbTFJTsv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 15:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTFJTsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 15:48:43 -0400
Received: from holomorphy.com ([66.224.33.161]:46553 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262176AbTFJTrn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 15:47:43 -0400
Date: Tue, 10 Jun 2003 13:01:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 (virgin) hangs running SDET
Message-ID: <20030610200119.GE26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org
References: <60380000.1055188542@flay> <20030609140834.11ad0d63.akpm@digeo.com> <5930000.1055254447@[10.10.2.4]> <12190000.1055266471@flay> <20030610124613.40e65da7.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030610124613.40e65da7.akpm@digeo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 10, 2003 at 12:46:13PM -0700, Andrew Morton wrote:
> Also spinlock debugging enabled.  It would be nice to run with preempt and
> sleep-in-spinlock debugging enabled too, but I think preempt is broken on
> NUMA?

AIUI the only big issue is numa_node_id() called outside preempt-
disabled code sections. IMHO this is a non-issue as the information
gathered there is used solely for heuristic/speculative purposes.

Zwane's run CONFIG_PREEMPT just fine on OSDL's NUMA-Q's AIUI.


-- wli
