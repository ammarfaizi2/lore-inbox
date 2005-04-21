Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVDUL2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVDUL2t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 07:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVDUL2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 07:28:48 -0400
Received: from ns1.q-leap.de ([153.94.51.193]:62100 "EHLO mail.q-leap.de")
	by vger.kernel.org with ESMTP id S261292AbVDUL20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 07:28:26 -0400
From: Roland Fehrenbacher <rf@q-leap.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16999.36436.604591.941925@gargle.gargle.HOWL>
Date: Thu, 21 Apr 2005 13:28:20 +0200
To: linux-kernel@vger.kernel.org
Subject: journal_callback_set
X-Mailer: VM 7.17 under 21.4 (patch 16) "Corporate Culture" XEmacs Lucid
Reply-To: rf@q-leap.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed, that starting from 2.6.10, the function (fs/jbd/transaction.c)

void journal_callback_set(handle_t *handle,
              void (*func)(struct journal_callback *jcb, int error),
                   struct journal_callback *jcb)

along with the structure members of handle_s (include/linux/jbd.h)

struct list_head        h_jcb;

and the following members of transaction_s

spinlock_t              t_jcb_lock;
struct list_head        t_jcb;

has been removed. Since I didn't find any discussion of this on this
list or anywhere else on the web, I wondered about the motivation
behind this, and how code that references these function/members
should be modified. Is it dangerous to reinclude the eliminated parts
of the code?

Please reply to me personnally, since I am not subscribed to the list.

Thanks,

Roland

