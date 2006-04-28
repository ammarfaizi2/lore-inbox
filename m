Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751822AbWD1AVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbWD1AVB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbWD1AUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:20:39 -0400
Received: from cantor.suse.de ([195.135.220.2]:35545 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751735AbWD1AUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:20:19 -0400
Date: Thu, 27 Apr 2006 17:18:41 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       norbert@tretkowski.de, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 09/24] for_each_possible_cpu
Message-ID: <20060428001841.GJ18750@kroah.com>
References: <20060428001226.204293000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="for_each_possible_cpu.patch"
In-Reply-To: <20060428001557.GA18750@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Andrew Morton <akpm@osdl.org>

Backport for_each_possible_cpu() into 2.6.16.  Fixes the alpha build, and any
future occurrences.


Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/linux/cpumask.h |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.16.11.orig/include/linux/cpumask.h
+++ linux-2.6.16.11/include/linux/cpumask.h
@@ -408,6 +408,7 @@ extern cpumask_t cpu_present_map;
 })
 
 #define for_each_cpu(cpu)	  for_each_cpu_mask((cpu), cpu_possible_map)
+#define for_each_possible_cpu(cpu)  for_each_cpu_mask((cpu), cpu_possible_map)
 #define for_each_online_cpu(cpu)  for_each_cpu_mask((cpu), cpu_online_map)
 #define for_each_present_cpu(cpu) for_each_cpu_mask((cpu), cpu_present_map)
 

--
