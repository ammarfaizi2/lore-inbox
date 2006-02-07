Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWBGU3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWBGU3f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 15:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbWBGU3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 15:29:35 -0500
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:64904 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964881AbWBGU3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 15:29:34 -0500
Date: Tue, 7 Feb 2006 15:25:52 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: 2.6.16-rc1-mm5: explanation text for
  kretprobe-kretprobe-booster.patch
To: Andrew Morton <akpm@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
Message-ID: <200602071528_MC3-1-B7DD-D2ED@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In kretprobe-kretprobe-booster.patch:

> From: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
>
> What does this do?
>

Here's a description:

In normal operation, kretprobe makes a target function return
to trampoline code. A kprobe (called trampoline_probe) has
been inserted in the trampoline code. When the kernel hits this
kprobe, it calls kretprobe's handler and it returns to the original
return address.

Kretprobe-booster removes the trampoline_probe. It allows the
trampoline code to call kretprobe's handler directly instead of
invoking kprobe. The trampoline code returns to the original return
address.

-- 
Chuck
