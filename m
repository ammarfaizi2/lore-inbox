Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbWEWRJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWEWRJu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 13:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWEWRJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 13:09:50 -0400
Received: from hera.kernel.org ([140.211.167.34]:3546 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750863AbWEWRJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 13:09:49 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Question] how to follow a symlink via a dentry?
Date: Tue, 23 May 2006 10:08:47 -0700
Organization: OSDL
Message-ID: <20060523100847.7056909a@localhost.localdomain>
References: <1148403363.22855.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1148404127 21269 10.8.0.54 (23 May 2006 17:08:47 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 23 May 2006 17:08:47 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.1.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2006 12:56:03 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> What is the best way from inside the kernel, to find the dentry that
> another dentry points to via symlink?
> 
> Scenario:
> 
> I have a kobj of a device in the sysfs system.  Inside a directory of
> the kobj, is a symlink to another device I need to get.  I can find the
> dentry of the symlink, but I haven't found a good way to get to the
> dentry of what the symlink points to.
> 
> Is there a standard way to do this, or do I need to start hacking at the
> follow_link of the sysfs directory to get what I want?
> 
> Do I need to hack up something like page_readlink to get the path, and
> then do vfs_follow_link to get the rest.  Another thing is that I can't
> rely on what current->fs points to.
> 
> Thanks,
> 
> -- Steve
>

Sysfs reflects kernel object linkage, you should not be using
file access to find kernel objects.  You should use the pointers
instead.
