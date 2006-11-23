Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757265AbWKWBe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757265AbWKWBe7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 20:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757262AbWKWBe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 20:34:56 -0500
Received: from smtp-out.google.com ([216.239.45.12]:62131 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1757267AbWKWBez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 20:34:55 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:content-type:
	organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=fsjB2iqFoUxqWa6V7vzXowN8FXH1h5MM4eQqz9NuelG8xVPJ3iW8AMtJCYAICrGIX
	Jgmlfr9qpDBAwdQu6utDQ==
Subject: [Patch2/4]: fake numa for x86_64 patches
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Andi Kleen <ak@suse.de>
Cc: Mel Gorman <mel@csn.ul.ie>, David Rientjes <rientjes@cs.washington.edu>,
       Paul Menage <menage@google.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 22 Nov 2006 17:34:27 -0800
Message-Id: <1164245667.29844.151.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch increases the NODE_SHIFT from 6 to 8 to allow maximum of 256
nodes.

Signed-off-by: David Rientjes <reintjes@google.com>
Signed-off-by: Paul Menage <menage@google.com>
Signed-off-by: Rohit Seth <rohitseth@google.com>

--- linux-2.6.19-rc5-mm2.org/arch/x86_64/Kconfig	2006-11-22 12:20:55.000000000 -0800
+++ linux-2.6.19-rc5-mm2/arch/x86_64/Kconfig	2006-11-20 11:44:55.000000000 -0800
@@ -348,7 +348,7 @@ config K8_NUMA
 
 config NODES_SHIFT
 	int
-	default "6"
+	default "8"
 	depends on NEED_MULTIPLE_NODES
 
 # Dummy CONFIG option to select ACPI_NUMA from drivers/acpi/Kconfig.


