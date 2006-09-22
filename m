Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWIVJ6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWIVJ6o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 05:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWIVJ6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 05:58:44 -0400
Received: from namsan.hanyang.ac.kr ([166.104.11.34]:47262 "HELO
	ece.hanyang.ac.kr") by vger.kernel.org with SMTP id S932079AbWIVJ6o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 05:58:44 -0400
Message-ID: <4513B3CE.50805@ece.hanyang.ac.kr>
Date: Fri, 22 Sep 2006 18:58:38 +0900
From: a287848 <a287848@ece.hanyang.ac.kr>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Different value in journal block after crash?
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi I'm moweon.

Now I'm making redundancy module in my jbd based file system.

When I tesed and dumped its block, I found one funny stuation.


First I modified */commit.c/* in jbd directory to print commit complete
message and it's block number.
( add printk after wait_on_buffer )


After I saw this message from kernel just like this

(*NOTICE: Commit complete , its block number : 560 *)

I read its contents from block number 1 to 101 into file

And I read it again after suddenly turn off my work station.

, I think it must has same value becuase journal commit block was
already written behind block number 101 .


But when I campared two file, it's different .

Why it happen? Does jbd use some trick in block management?

Dear













