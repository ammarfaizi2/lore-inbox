Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbTIXLWQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 07:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbTIXLWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 07:22:15 -0400
Received: from dyn-ctb-203-221-73-21.webone.com.au ([203.221.73.21]:19726 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261251AbTIXLWO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 07:22:14 -0400
Message-ID: <3F717E62.5020404@cyberone.com.au>
Date: Wed, 24 Sep 2003 21:22:10 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][RFC] runtime selectable IO schedulers
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.kerneltrap.org/~npiggin/elv-select.patch-030924

Against test5-mm4. This is commented a bit better than the previous
version I sent to Al and Jens.

sysfs interface is /sys/block/*/queue/io_scheduler. Valid values are
as, deadline, noop, cfq. Switching schedulers under disk load works fine
in my tests. sysfs stuff seems to be working nicely and handles lingering
userspace references properly.

Review of the kobject / sysfs stuff would be especially helpful. Thanks.


