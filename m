Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030443AbWBHCMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030443AbWBHCMA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 21:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030445AbWBHCMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 21:12:00 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:15583 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1030443AbWBHCL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 21:11:58 -0500
From: Grant Coady <gcoady@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6 vs 2.4, ssh terminal slowdown
Date: Wed, 08 Feb 2006 13:11:49 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

grant@deltree:~$ uname -r
2.6.15.3a
grant@deltree:~$ time grep -v 192\.168\. /var/log/apache/access_log| cut -c-95
...
2006-02-08 12:38:13 +1100: bugsplatter.mine.nu 193.196.182.215 "GET /test/linux-2.6/tosh/ HTTP/

real    0m8.537s
user    0m0.970s
sys     0m1.100s

--> reboot to 2.4.32-hf32.2

grant@deltree:~$ uname -r
2.4.32-hf32.2
grant@deltree:~$ time grep -v 192\.168\. /var/log/apache/access_log| cut -c-95
...
2006-02-08 12:38:13 +1100: bugsplatter.mine.nu 193.196.182.215 "GET /test/linux-2.6/tosh/ HTTP/

real    0m2.271s
user    0m0.730s
sys     0m0.540s

Still a 4:1 slowdown, machine .config and dmesg info:
  http://bugsplatter.mine.nu/test/boxen/deltree/

While it is very nice to know I can run recent 2.6 kernels without a fuss, 
2.4.latest feels better in this particular context.

This console sluggishness is noticeable enough on older hardware for me to 
forgo exercising 2.6.latest.stable bugs for much time on it ;)

For those suffering deja vu, yes, I reported this last month (or, recently).

Grant.
