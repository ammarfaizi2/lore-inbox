Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbUCJHum (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 02:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbUCJHum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 02:50:42 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:25302 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261959AbUCJHul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 02:50:41 -0500
Date: Wed, 10 Mar 2004 08:50:39 +0100
From: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Redirection of STDERR
Message-Id: <20040310085039.6c234fbc.Christoph.Pleger@uni-dortmund.de>
In-Reply-To: <jehdwylz0x.fsf@sykes.suse.de>
References: <20040308111349.030feea6.Christoph.Pleger@uni-dortmund.de>
	<404DEAFD.8090802@bcgreen.com>
	<jehdwylz0x.fsf@sykes.suse.de>
Organization: Universitaet Dortmund
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; sparc-sun-solaris2.6)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> >> In my initialization scripts for hotplug (written for bash) the
> >> following command is used to redirect output which normally goes to
> >> stderr to the system logger:
> >> "exec 2> >(logger -t $0[$$])"
> > I don't remember this syntax as legal.
> 
> That's the process substitution feature of bash, quite handy when you
> want to get an fd connected to a pipe.

I found out that the problem exists with bash 2.05b, but not with 2.05a.
The reason is that with 2.05a the command uses the file descriptors
under /dev/fd0 for the pipe, but with 2.05b the command creates a pipe
under /tmp. Obviously, the 2.05b mechanism worked with Kernel 2.4, but
not with 2.6.

Christoph 
