Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262343AbVAELzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbVAELzs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 06:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbVAELzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 06:55:48 -0500
Received: from web60603.mail.yahoo.com ([216.109.118.223]:32937 "HELO
	web60603.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262343AbVAELzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 06:55:41 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=zJFFPfhZXQakG6SMrW7KF1fLnUqxMcLLMbwA1qVMeNxjg6v2UAzDaa+Nfb8Z5GxASPHaXTdsQf46Nt0sr5PN0dKYntrY1oS+k+EAk4v1lr/RdZo0QsAElLzMesN+jcVwOdH2m3x3kIICio2KZ6bOEHBvwcMNiO18qfOBE13jqIY=  ;
Message-ID: <20050105115540.18624.qmail@web60603.mail.yahoo.com>
Date: Wed, 5 Jan 2005 03:55:40 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Linked list printing problem
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello kernel experts,
  while printing the linked list in Linux, I got a
problem. If the list has only one element, that
element is not displayed. But if we have more than one
element all the entries are printed. What could be the
problem? I have also included the code snippet
 
struct my_process
{
	struct list_head list;
	unsigned long pid;
	unsigned int pipe_read_end;
	unsigned int pipe_write_end;
};

struct my_process proinit = {
	.list = LIST_HEAD_INIT(proinit.list),
	.pid = -1,
	.pipe_read_end = -1,
	.pipe_write_end = -1
};

list_for_each(p,&proinit.list)	{
	my = list_entry(p, struct my_process, list);
		printk("\n%ld,", my -> pid);
		printk("%d,",  my -> pipe_read_end);
		printk("%d",  my -> pipe_write_end);
	}

Thanks,
selva


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - now with 250MB free storage. Learn more.
http://info.mail.yahoo.com/mail_250
