Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbVACTue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVACTue (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 14:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVACTud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 14:50:33 -0500
Received: from holomorphy.com ([207.189.100.168]:54429 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261620AbVACTuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 14:50:21 -0500
Date: Mon, 3 Jan 2005 11:50:16 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: jbarnes@engr.sgi.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [bootfix] pass used_node_mask by reference in 2.6.10-mm1
Message-ID: <20050103195016.GP29332@holomorphy.com>
References: <20050103191319.GO29332@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103191319.GO29332@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 11:13:19AM -0800, William Lee Irwin III wrote:
> Without passing this parameter by reference, the changes to used_node_mask
> are meaningless and do not affect the caller's copy.
> This leads to boot-time failure. This proposed fix passes it by reference.

This proposed fix is an actual fix according to my own testing.

Without the patch applied, my quad em64t does not boot, and livelocks
prior to console_init().

With the patch applied, my quad em64 boots and runs normally.


-- wli
