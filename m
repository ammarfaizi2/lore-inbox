Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269507AbUJFVdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269507AbUJFVdN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 17:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269508AbUJFVdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 17:33:00 -0400
Received: from inetc.connecttech.com ([64.7.140.42]:62470 "EHLO
	inetc.connecttech.com") by vger.kernel.org with ESMTP
	id S269497AbUJFVbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 17:31:05 -0400
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Problems in list.h macros?
Date: Wed, 6 Oct 2004 17:31:04 -0400
Organization: Connect Tech Inc.
Message-ID: <030801c4abeb$c9316ba0$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am referring to a stock 2.4.27's linux/list.h.

1: list_for_each(_entry)_safe() calls seem not to be as safe as they
are implied to be. They seem to be only actually safe *iff* a
list_del() is the only operation performed on the list entry. If pos
is freed after a list_del, aren't you toast? If n has its pointers
modified, say by a list_add() to a different list, don't you end up
at the new list instead of the original list? Shouldn't this be noted
in the macro comments?

..Stu

