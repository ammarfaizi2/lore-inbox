Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266756AbUJFX4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266756AbUJFX4y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 19:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269646AbUJFX4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 19:56:49 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:56810 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S269600AbUJFXzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 19:55:11 -0400
Subject: cp -arl stuck in __wait_on_freeing_inode (ext3)
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1097106828.9693.52.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 07 Oct 2004 09:53:57 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I began a bk export -du patch and shortly afterwards a cp -arl on the
kernel source tree. The latter got stuck in

ext3_lookup
iget_locked
find_inode_fast
__wait_on_freeing_inode
schedule

The box is running 2.6.8.1 with SMP, HT scheduler and preempt (can send
a full .config if someone wants it). No other processes are stuck; it
looks to me like it lost a race. Is this a known/fixed issue, or is
there something I can do to diagnose further. I have KDB compiled in and
haven't rebooted yet.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

