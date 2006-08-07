Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWHGIGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWHGIGs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 04:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWHGIGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 04:06:48 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:19148
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751146AbWHGIGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 04:06:48 -0400
Message-Id: <44D710D9.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Mon, 07 Aug 2006 09:07:21 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: "Chuck Ebbert" <76306.1226@compuserve.com>
Cc: "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] i386: fix stuck unwind into kernel thread
References: <200608061458_MC3-1-C742-330A@compuserve.com>
In-Reply-To: <200608061458_MC3-1-C742-330A@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Chuck Ebbert <76306.1226@compuserve.com> 06.08.06 20:56 >>>
>We cannot unwind past kernel_thread_helper.

Just as mentioned before - we shouldn't add endless special cases to the code that interprets the unwind
information, but rather fix the unwind information so that it properly reflect the actual state. Like in the
other case, the piece of code should be properly annotated, which would require it to be moved into
an assembly file (it escapes me why code like that was ever placed in a C file).

Jan
