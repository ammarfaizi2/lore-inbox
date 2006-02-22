Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751566AbWBVWfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbWBVWfc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbWBVWfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:35:32 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:53734 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751569AbWBVWfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:35:31 -0500
Message-ID: <43FCE664.1A0472E6@tv-sign.ru>
Date: Thu, 23 Feb 2006 01:32:04 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       David Howells <dhowells@redhat.com>,
       Christoph Lameter <clameter@engr.sgi.com>
Subject: [PATCH 0/3] make threads traversal ->siglock safe
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With this patch series we don't need tasklist_lock to iterate over thread
group anymore. The actual change (PATCH 3/3) is a one-liner, patches 1-2
are needed to make an illusion of hard and nontrivial work.

Oleg.
