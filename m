Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWHACZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWHACZO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 22:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbWHACZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 22:25:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:37648 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751529AbWHACZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 22:25:13 -0400
X-IronPort-AV: i="4.07,200,1151910000"; 
   d="scan'208"; a="99616429:sNHT18178650"
Date: Mon, 31 Jul 2006 19:14:49 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: paulmck@us.ibm.com, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: synchronous signal in the blocked signal context
Message-ID: <20060731191449.B4592@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (b0423a0d9cc836b2c3d796623cd19236bfedfe63)

[PATCH] Remove duplicate code in signal.c

reverts a patch introduced by Linus long time back.

http://linux.bkbits.net:8080/linux-2.6/gnupatch@3f0621871mAhWfFZzuA74eKKLvE6OQ

Was this intentional?

With the current mainline code, SIGSEGV inside a SIGSEGV handler will endup
in linux handling endless recursive faults.

Just wondering if this has been discussed before and is intentional.

thanks,
suresh
