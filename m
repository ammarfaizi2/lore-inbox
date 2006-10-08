Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWJHTSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWJHTSq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 15:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWJHTSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 15:18:46 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:38804
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751347AbWJHTSp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 15:18:45 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Really good idea to allow mmap(0, FIXED)?
Date: Sun, 8 Oct 2006 21:18:29 +0200
User-Agent: KMail/1.9.4
References: <200610052059.11714.mb@bu3sch.de> <eg6bk4$7r1$1@taverner.cs.berkeley.edu> <452844AB.2050406@goop.org>
In-Reply-To: <452844AB.2050406@goop.org>
Cc: David Wagner <daw-usenet@taverner.cs.berkeley.edu>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610082118.29200.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 October 2006 02:22, Jeremy Fitzhardinge wrote:
> Though (*something_ops->thingy)() becomes a lot more interesting if 
> something_ops or ->thingy is NULL...

It's always very critical if a userspace program can modify some
data in the kernel. Be it function pointers or plain data.
Also consider something like:

if (task->uid == 0)
	allow_access_to_time_machine();
else
	return -EPERM;

Now if "task" may be a NULL pointer (due to a bug) it
can be exploited.

PS: Please don't drop me from the CC list ;)

-- 
Greetings Michael.
