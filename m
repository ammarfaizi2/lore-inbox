Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265544AbTGCIOJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 04:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265563AbTGCIOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 04:14:09 -0400
Received: from asplinux.ru ([195.133.213.194]:11013 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S265544AbTGCIOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 04:14:08 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Kirill Korotaev <dev@sw.ru>
Organization: SW Soft
To: manfred@colorfullife.com
Subject: Again: Fix multithread coredump deadlock (patch Manfred Spraul)
Date: Thu, 3 Jul 2003 12:38:10 +0400
User-Agent: KMail/1.4.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200307031238.10570.dev@sw.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

There was a patch some time ago included in linux-2.4.17-pre6 which fixed mmap 
semaphore deadlock in do_coredump (double down_read() on mmap_sem).
This fix introduces down_write() on mmap_sem and uses get_user_pages() 
function to avoid do_page_fault().
The question is why down_write() is used in elf_core_dump() (instead of 
down_read())?

Kirill

