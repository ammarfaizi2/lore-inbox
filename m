Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264430AbUGZQym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264430AbUGZQym (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 12:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUGZQym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 12:54:42 -0400
Received: from village.ehouse.ru ([193.111.92.18]:20233 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S265175AbUGZPno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 11:43:44 -0400
From: "Alexander Y. Fomichev" <gluk@php4.ru>
Reply-To: "Alexander Y. Fomichev" <gluk@php4.ru>
To: linux-kernel@vger.kernel.org
Subject: race in expand_stack in 2.6.7 ?
Date: Mon, 26 Jul 2004 19:43:40 +0400
User-Agent: KMail/1.6.2
Cc: Andrea Arcangeli <andrea@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407261943.40472.gluk@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	
G'Day.

Some months ago i've reported about bug which Andrea defined as
"race in expand_stack with threads" (http://lkml.org/lkml/2004/4/14/52),
but it was related to -aa branch (More precisely 2.6.5-aa5).
After applied patch from Andrea (many tnx), i did not notice
any troubles with 2.6.5-aa5 and later with 2.6.7 until today
when i've caught very similar bug(?) on the same system. 
[Dual P4 Xeon 2.4GHz, 2G ECC RAM - (production web-server)
Gentoo, kernel 2.6.7]

System behaviour and trace are nearly the same, system alive but
i couldn't do ps, pkill etc. Here is a trace:

http://sysadminday.org.ru/expand_stack_race/trace-20040726


config:		http://sysadminday.org.ru/expand_stack_race/config-2.6.7
cpuinfo:        http://sysadminday.org.ru/expand_stack_race/cpuinfo
lspci:          http://sysadminday.org.ru/expand_stack_race/lspci 
lspci -vvn      http://sysadminday.org.ru/expand_stack_race/lspci-vvn


-- 
Best regards.
        Alexander Y. Fomichev <gluk@php4.ru>
        Public PGP key: http://sysadminday.org.ru/gluk.asc
