Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264222AbTKTCfJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 21:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264226AbTKTCfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 21:35:09 -0500
Received: from holomorphy.com ([199.26.172.102]:42411 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264222AbTKTCfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 21:35:04 -0500
Date: Wed, 19 Nov 2003 18:34:57 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Christopher Li <lkml@chrisli.org>
Cc: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-mm4 (only) and vmware
Message-ID: <20031120023457.GC22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Christopher Li <lkml@chrisli.org>,
	Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20031119181518.0a43c673.vmlinuz386@yahoo.com.ar> <20031119223425.GA20549@64m.dyndns.org> <20031120014718.GA22764@holomorphy.com> <20031119232246.GA20840@64m.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031119232246.GA20840@64m.dyndns.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 19, 2003 at 06:22:46PM -0500, Christopher Li wrote:
> Thanks,  I post a totally untested patch follows, but the testing of
> which kernel has this feature is not completed yet.
> Is there a way to reliably detect which kernel has this change?
> Look at all the ifdef I need to make to keep the module working
> with other kernels.  :-(
> Best Regards,
> Chris

akpm wants us not to barf when ->nopage() methods not updated to the
new signature are used, so we're either setting the initial value of
ret in do_no_page() to something that won't get barfed on by
do_page_fault() or teaching all the fault handlers to ignore invalid
return values. As far as fixing the warning, the #ifdef is still needed.

I'm going to ruminate on non-fatal methods of complaining loudly.


-- wli
