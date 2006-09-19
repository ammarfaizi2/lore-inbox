Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751848AbWISJzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbWISJzJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 05:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbWISJzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 05:55:09 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:18033 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750924AbWISJzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 05:55:07 -0400
Date: Tue, 19 Sep 2006 17:03:02 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: Don Mullis <dwm@meer.net>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, akpm@osdl.org, okuji@enbug.org
Subject: Re: [patch 2/8] fault-injection capabilities infrastructure
Message-ID: <20060919090302.GB24271@miraclelinux.com>
References: <20060914102012.251231177@localhost.localdomain> <20060914102030.721230898@localhost.localdomain> <1158645054.2419.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158645054.2419.3.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2006 at 10:50:54PM -0700, Don Mullis wrote:
> Replace individual structure element comments with reference
> to Documentation/fault-injection/fault-injection.txt
> 
> Init "interval" to 1 (smallest useful value).
> Init "times" to 1 rather than -1 (infinity), for fewer 
> accidental system lockups.
> 

This patch also applied with small coding style fix.

>  #define DEFINE_FAULT_ATTR(name) \
> -	struct fault_attr name = { .times = ATOMIC_INIT(-1), }
> +	struct fault_attr name = { .interval=1, .times = ATOMIC_INIT(1), }

	struct fault_attr name = { .interval = 1, .times = ATOMIC_INIT(1), }

