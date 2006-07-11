Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWGKWEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWGKWEU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWGKWEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:04:20 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:44417 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S932170AbWGKWET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:04:19 -0400
Message-ID: <44B42064.4070802@namesys.com>
Date: Tue, 11 Jul 2006 15:04:20 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Reiserfs mail-list <Reiserfs-List@namesys.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: short term task list for Reiser4
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please feel free to comment on this list and the order of its tasks:

0) fix all bugs as they arise

1) get batch_write into the -mm kernel --- small task

2) get read optimization code into the -mm kernel (coded and probably
debugged but not fully tested and not sent in yet) --- small task

3) get EVERYTHING into wiki (migration has started already, thanks flx).

4) review complaints of pauses while using reiser4 --- size of task
unknown, and it is also unknown how much we may have fixed it while
writing recent patches.

5) review crypt-compress code --- full code review --- substantive task

6) optimize fsync --- substantive task which requires using fixed area
for write twice logging, and using write twice logging for fsync'd
data.  It might require creating mount options to choose whether to
optimize for serialized sequential fsyncs vs. lazy fsyncs.

7) review all of our installation instructions --- I am already doing
that, but volunteers who will help out our wiki would be sorely
appreciated.  Installing reiser4 as the root for each distro needs
step-by-step instructions.

8) review our kernel documentation --- I should do that but when will I
have time?

Unfortunately, our code stability is going to decrease for a bit due to
all these changes to the read and write code --- no way to cure that but
passage of time.   On the other hand, our CPU usage went way down. 
Reiser4's only performance weakness now is fsync.  

Once the crypt-compress code is ready, we will release Reiser4.1-beta
(with plugins, releasing a beta means telling users that if they mount
-o reiser4.1-beta then cryptcompress will be their default plugin, and
if they don't, then they are using Reiser4.0 still).  Doubling our
performance and halving our disk usage is going to be fun.
