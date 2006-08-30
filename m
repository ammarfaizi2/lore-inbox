Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWH3NwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWH3NwO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 09:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbWH3NwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 09:52:14 -0400
Received: from main.gmane.org ([80.91.229.2]:51371 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751056AbWH3NwN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 09:52:13 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: yipee <yipeeyipeeyipeeyipee@yahoo.com>
Subject: struct page for a non-physical-memory address
Date: Wed, 30 Aug 2006 13:51:21 +0000 (UTC)
Message-ID: <loom.20060830T151949-979@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 62.90.3.11 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060728 Firefox/1.5.0.6)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I want to let a nopage mmap handler return a 'struct page' that
refers to a non-physical-memory address (e.g. some device memory).
pfn_valid(x) fails for this address (returning 0) so
pfn_to_page(x) can't be used.
How can I implement this functionality? Must the VM_IO bit be set?
Are there several methods to implement this?


thanks,
y



