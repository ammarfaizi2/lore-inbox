Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbTENFdp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 01:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTENFdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 01:33:45 -0400
Received: from holomorphy.com ([66.224.33.161]:44736 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261808AbTENFdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 01:33:43 -0400
Date: Tue, 13 May 2003 22:46:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: gibbs@scsiguy.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: ahc_linux_map_seg() compile/style/data corruption fixes
Message-ID: <20030514054625.GF2444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	gibbs@scsiguy.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20030514044934.GC29926@holomorphy.com> <20030514053747.GE2444@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514053747.GE2444@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 10:37:47PM -0700, William Lee Irwin III wrote:
> Hmm, 2.5.x is supposed to guarantee most (if not all) of the
> preconditions the code here is trying to (re)establish. Probably the
> only use of not ripping out the 4GB spanning code and segment count
> checks is to keep driver versions synched. As it stands, this doesn't
> compile and if ever invoked the code not needed for 2.5 will not behave
> as expected (though thankfully a nop). Maybe a (shudder) #ifdef to rip
> out the overhead for 2.5 should be added esp. as post gcc-3.0 probably
> can't compile earlier kernels anyway.

Clarification: the code before my patch doesn't compile with gcc-3.3;
the code after it does. Mutatis mutandis with respect to the unexpected
behavior.


-- wli
