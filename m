Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269660AbUJMKTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269660AbUJMKTl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 06:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269666AbUJMKTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 06:19:41 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:35511 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S269660AbUJMKTk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 06:19:40 -0400
Subject: __put_task_struct unresolved when being used in modules
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF31970E09.9A7F3D25-ONC1256F2C.00380546-C1256F2C.00389262@de.ibm.com>
From: Thomas Spatzier <thomas.spatzier@de.ibm.com>
Date: Wed, 13 Oct 2004 12:17:54 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.0.2CF2HF259 | March 11, 2004) at
 13/10/2004 12:19:38
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





I have a module that keeps a reference to a task_struct and uses
get_task_struct and put_task_struct to increment/decrement the
task_struct's ref count.
Function __put_task_struct defined in kernel/fork.c does not have
an associated EXPORT_SYMBOL , so I get an unresolved symbol
error.
Is there a reason why __put_task_struct is not exported? Otherwise,
I would just add the missing EXPORT_SYMBOL. There are a number
of EXPORT_SYMBOLs already defined in fork.c anyway.

Regards,
Thomas

