Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbVIFLQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbVIFLQq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 07:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbVIFLQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 07:16:46 -0400
Received: from mail.customers.edis.at ([62.99.242.131]:8342 "EHLO
	smtp-1.edis.at") by vger.kernel.org with ESMTP id S964808AbVIFLQp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 07:16:45 -0400
Message-ID: <431D7A94.3080006@lawatsch.at>
Date: Tue, 06 Sep 2005 13:16:36 +0200
From: Philip Lawatsch <philip@lawatsch.at>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050724 Thunderbird/1.0.6 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: intr in /proc/stat and number of syscalls made
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I'm trying to log some stats for one of my server.

Now what I wanted to log is the number of pagefaults and the number of 
syscalls done since system startup.
(I'm on a system without sysenter)

I thought that /proc/stat's intr line would provide information about 
how often an interrupt was called. But it looks like there are only 
stats about the irqs in there and not about all interrupts.

I've already found /proc/vmstat | grep pgfault which will give me the 
number of pagefaults, but I'm still looking for a way to get the number 
of syscalls.

I also think that the Documenation about /proc/stat is misleading 
(perhaps putting the word irq somewhere in there would be a good idea).


So, is there a way to find out how often the syscall interrupt / 
sysenter handler was run? I'd actually prefer to get the number for each 
interrupt because then I could also track some other nice things.


kind regards Philip
