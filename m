Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbULaXGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbULaXGb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 18:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbULaXGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 18:06:31 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:49324 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262165AbULaXG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 18:06:28 -0500
Date: Fri, 31 Dec 2004 18:06:24 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.5isms
Message-ID: <20041231230624.GA29411@andromeda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: Justin Pryzby <justinpryzby@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, I have more 2.5isms for the list.  ./fs/binfmt_elf.c:

  #ifdef CONFIG_X86_HT
                  /*
                   * In some cases (e.g. Hyper-Threading), we want to avoid L1
                   * evictions by the processes running on the same package. One
                   * thing we can do is to shuffle the initial stack for them.
                   *
                   * The conditionals here are unneeded, but kept in to make the
                   * code behaviour the same as pre change unless we have
                   * hyperthreaded processors. This should be cleaned up
                   * before 2.6
                   */

                  if (smp_num_siblings > 1)
                          STACK_ALLOC(p, ((current->pid % 64) << 7));
  #endif

Happy y2k5,
Justin
