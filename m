Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbTENQXX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 12:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbTENQXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 12:23:23 -0400
Received: from web40611.mail.yahoo.com ([66.218.78.148]:14898 "HELO
	web40611.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262161AbTENQXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 12:23:16 -0400
Message-ID: <20030514163558.56819.qmail@web40611.mail.yahoo.com>
Date: Wed, 14 May 2003 09:35:58 -0700 (PDT)
From: Muthian Sivathanu <muthian_s@yahoo.com>
Subject: isolated memory pools ?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Does anyone know if there is a simple way to manage
isolated memory pools in linux ?  I am writing a
device driver that does a lot of memory allocation to
keep track of some internal data structures. However,
when the system is subjected to an I/O intensive
workload for instance, the file system cache takes
away a lot of memory, leading to unpredictable delays
in memory allocation within my driver, which creates a
lot of performance problems.

Ideally, I would like to be able to allocate my own
memory pool, say, with 10% of the host memory, and
then have total control over it, i.e. the rest of the
kernel should not allocate from this space, and my
local free_pages should return memory back to my local
pool.  One obvious way to do this would be to pin
those pages to memory and then write my own memory
management routines to handle allocations within the
pool, but that seems time consuming and hard.  Is
there a way the existing kernel memory management
routines can be harnessed to manage
such an isolated free pool ?

Thanks,
Muthian.

P.S: Please CC my personal address in your replies
since I am not a member of
the mailing list.


__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com
