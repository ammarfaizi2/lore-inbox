Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271119AbTG1VwT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 17:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271120AbTG1VwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 17:52:19 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:46644 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S271119AbTG1VwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 17:52:17 -0400
From: Ben Twijnstra <bentw@chello.nl>
Reply-To: bentw@chello.nl
To: linux-kernel@vger.kernel.org
Subject: Machine Check Exception in 2.6.0-test2
Date: Mon, 28 Jul 2003 23:52:15 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307282352.15775.bentw@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

When running a fairly CPU and thread-hungry application under 2.5.75, 
2.6.0-test1 and 2.6.0-test2 I'm getting the following error messages on the 
console:

Jul 25 00:16:31 durak kernel: CPU 0: Machine Check Exception: 0000000000000004
Jul 25 00:16:31 durak kernel: Bank 0: b600000000000175 at 0000000025a0cff8
Jul 25 00:16:31 durak kernel: Kernel panic: CPU context corrupt

Once I get this message, one of the threads becomes unkillable yet remains 
soaking up CPU cycles.

This does not happen in the 2.4 kernels. How do I go about finding the source 
of the problem? The address indicated in the second line indicates that this 
happened somewhere in userspace (0x25a0cff8), but since this is a commercial 
package I don't have any symbolic info. This last address changes between 
runs, so I assume it's a virtual address.

Any ideas welcome.

Best regards,



Ben

