Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752059AbWCIXiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbWCIXiw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752063AbWCIXiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:38:52 -0500
Received: from smtp-out.google.com ([216.239.45.12]:22007 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1752059AbWCIXiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:38:51 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
	b=e8UlDRBw8ceFBCS6biM0Pieq7nv7b3eoe6KZMNxf/CLMLM/KgkwoIaUZBxNLfOz2o
	dA7m6puvsHmLQg8F4x9dg==
Message-ID: <4410BC6A.6020002@google.com>
Date: Thu, 09 Mar 2006 15:38:18 -0800
From: Markus Gutschke <markus@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Debian/1.7.12-0ubuntu05.04
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Daniel Kegel <dkegel@google.com>, Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH 1/1]: arm: _syscallX() macros must mark "memory" as clobbered
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Gutschke <markus@google.com>

While other platforms (including x86) have been fixed to mark memory as 
clobbered by _syscallX()'s, this bug has not yet been fixed for ARM. 
This patch adds the missing constraints and applies to version 2.6.15.6.

The bug can be tracked at http://bugzilla.kernel.org/show_bug.cgi?id=6205

Signed-off-by: Markus Gutschke <markus@google.com>

---
