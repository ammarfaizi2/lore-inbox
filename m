Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266249AbUITLRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266249AbUITLRl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 07:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUITLRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 07:17:41 -0400
Received: from asplinux.ru ([195.133.213.194]:32527 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S266249AbUITLRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 07:17:38 -0400
Message-ID: <414EBF2B.5090909@sw.ru>
Date: Mon, 20 Sep 2004 15:29:47 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Q] why switch_exec_pids() changes thread group leader pid?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've been looking through switch_exec_pids() function and found that it 
changes thread group leader PID/TGID. Is it really a good idea to change 
  pid of the process during it's lifetime? I could understand if it was 
happenning in the context of that process, but pid changes everytime a 
thread calls do_execve().

As far as I can see, leader doesn't have to do any of detach_pid()'s. 
Instead thread should change it's PID/TGID.

Am I wrong?

Kirill

