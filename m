Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262869AbVA2HPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262869AbVA2HPT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 02:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbVA2HPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 02:15:19 -0500
Received: from adsl-64-174-59-65.dsl.snfc21.pacbell.net ([64.174.59.65]:1228
	"EHLO vpnmail.netd.com") by vger.kernel.org with ESMTP
	id S262869AbVA2HPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 02:15:15 -0500
Date: Fri, 28 Jan 2005 20:23:55 -0800
From: Om <okuttan@netd.com>
To: Rock Gordon <rockgordon@yahoo.com>
Cc: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org, Bernd Petrovitsch <bernd@firmix.at>
Subject: Re: userspace vs. kernelspace address
Message-ID: <20050129042355.GA5527@netd.com>
Reply-To: Om <okuttan@netd.com>
References: <20050128075209.GA14153@vagabond> <20050128214051.34768.qmail@web41411.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050128214051.34768.qmail@web41411.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux turyx 2.6.9-exp 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 01:40:51PM -0800, Rock Gordon wrote:
> Hi everbody,
> 
> Thanks for your replies.
> 
> However I think my copy_to_user and copy_from_user are
> failing since the kernel-mode thread is copying data
> into another process's address space, and I am not
> sure how to do this. Do the get_fs() and set_fs()
> combinations let you do that? If not, then how do I do
My idea is on kernel thread is limited. But I think it is not possible to
any userspace address from any kernel thread because they do not have access
to it. Their proc_struct->mm field is empty.
I am not sure whether set_fs and get_fs help in this case.

HTH,
Om
