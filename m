Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbVKJAve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbVKJAve (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 19:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbVKJAve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 19:51:34 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:60083 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751167AbVKJAvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 19:51:33 -0500
Subject: Re: [PATCH 2/18] cleanups and bug fix in do_loopback()
From: Ram Pai <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Al Viro <viro@ftp.linux.org.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1EZxHb-00031A-00@dorka.pomaz.szeredi.hu>
References: <E1EZInj-0001Ef-9Z@ZenIV.linux.org.uk>
	 <E1EZNRz-0007EM-00@dorka.pomaz.szeredi.hu>
	 <1131439567.5400.221.camel@localhost>
	 <E1EZPm4-0007R7-00@dorka.pomaz.szeredi.hu>
	 <1131563299.5400.392.camel@localhost>
	 <E1EZxHb-00031A-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1131583868.5400.685.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 09 Nov 2005 16:51:08 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-09 at 13:15, Miklos Szeredi wrote:
> >  Yes there is some contradiction of some sorts on this. private-ness
> > means that the namespace must _not_ be accesible to processes
> > in other namespace. But 'file descriptor sent between two processes in
> > different namespaces' seems to break that guarantee.  
> 
> So..., are we going to check namespace in every file operation?  How
> much do you want to bet, that it won't break any applications?

I don't know. May be there are applications out there that depend on
this. It depends on the definition of private-ness of namespace. 
I am just saying that you raise a valid point.

I am not sure if fixing this behavior hurts more or soothes more,

Any idea?
RP


> 
> > > Also with ptrace() you can still access other process's namespace, so
> > > proc_check_root() is also too strict (or ptrace() too lax).
> > 
> > same here.
> 
> You mean, that ptrace() _is_ too lax?  Adding a namespace check to
> ptrace might well cause grief too.
> 
> The real question is, how private do we want the namespace to be.  I
> don't believe, we need to make it any more private than it currently
> is.
> 
> Miklos

