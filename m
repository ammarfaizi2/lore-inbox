Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbVKIVPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbVKIVPp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbVKIVPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:15:32 -0500
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:63244 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751383AbVKIVP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:15:29 -0500
To: linuxram@us.ibm.com
CC: viro@ftp.linux.org.uk, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <1131563299.5400.392.camel@localhost> (message from Ram Pai on
	Wed, 09 Nov 2005 11:08:19 -0800)
Subject: Re: [PATCH 2/18] cleanups and bug fix in do_loopback()
References: <E1EZInj-0001Ef-9Z@ZenIV.linux.org.uk>
	 <E1EZNRz-0007EM-00@dorka.pomaz.szeredi.hu>
	 <1131439567.5400.221.camel@localhost>
	 <E1EZPm4-0007R7-00@dorka.pomaz.szeredi.hu> <1131563299.5400.392.camel@localhost>
Message-Id: <E1EZxHb-00031A-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 09 Nov 2005 22:15:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Yes there is some contradiction of some sorts on this. private-ness
> means that the namespace must _not_ be accesible to processes
> in other namespace. But 'file descriptor sent between two processes in
> different namespaces' seems to break that guarantee.  

So..., are we going to check namespace in every file operation?  How
much do you want to bet, that it won't break any applications?

> > Also with ptrace() you can still access other process's namespace, so
> > proc_check_root() is also too strict (or ptrace() too lax).
> 
> same here.

You mean, that ptrace() _is_ too lax?  Adding a namespace check to
ptrace might well cause grief too.

The real question is, how private do we want the namespace to be.  I
don't believe, we need to make it any more private than it currently
is.

Miklos
