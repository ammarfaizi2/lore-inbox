Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263981AbUDQPlg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 11:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263990AbUDQPlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 11:41:36 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:57175 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263981AbUDQPlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 11:41:35 -0400
Subject: get_task_struct()
From: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1082216800.1447.26.camel@slack.domain.invalid>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 17 Apr 2004 12:46:40 -0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

Inside sys_ptrace, the function get_task_struct is invoked after
retrieving the child's task srtuct pointer. Why is it done? I have
tracked down the code and noticed that it is in fact an increment
on the (page?) counter. Can you help me understand it? 

Is it necessary to call free_task_struct whenever its get counterpart
is called?


** arch/i386/kernel/ptrace.c
>  read_lock(&tasklist_lock);
>  child = find_task_by_pid(pid);
>  if (child)
>              get_task_struct(child);
>  read_unlock(&tasklist_lock);

Thanks in advance,
Fabiano

