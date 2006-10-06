Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422791AbWJFSMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422791AbWJFSMR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 14:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWJFSMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 14:12:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44696 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932447AbWJFSMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:12:16 -0400
Date: Fri, 6 Oct 2006 11:12:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: caszonyi@rdslink.ro
cc: ebiederm@xmission.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Merge window closed: v2.6.19-rc1
In-Reply-To: <Pine.LNX.4.62.0610062041440.1966@grinch.ro>
Message-ID: <Pine.LNX.4.64.0610061110050.3952@g5.osdl.org>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
 <Pine.LNX.4.62.0610062041440.1966@grinch.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Oct 2006, caszonyi@rdslink.ro wrote:
> 
> In dmesg:
> warning: process `sleep' used the removed sysctl system call
> warning: process `alsactl' used the removed sysctl system call
> warning: process `nscd' used the removed sysctl system call
> warning: process `tail' used the removed sysctl system call

You need to compile with CONFIG_SYSCLT set to 'y' rather than 'n'.

Alternatively, you can probably fix it by just upgrading user-land, but 
the SYSCLT thing _does_ still exist, it's just deprecated and defaults to 
off by default..

(Or you can possibly even choose to just ignore the warnings, they 
probably won't affect any actual behaviour)

		Linus
