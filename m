Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbTJATVa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 15:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbTJATVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 15:21:30 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:61449 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262119AbTJATV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 15:21:27 -0400
Date: Wed, 1 Oct 2003 15:21:13 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Chris Wright <chrisw@osdl.org>
cc: torvalds@osdl.org, <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: sys_vserver
In-Reply-To: <20031001121536.J14398@osdlab.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0310011517440.19538-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Oct 2003, Chris Wright wrote:

> > 3) the needs that can be met with existing infrastructure, like
> >    CLONE_NEWNS or LSM should definately move out of the vserver
> >    patch in the port to 2.6
> 
> Glad to hear it.  I haven't looked closely at vserver since about 2.4.14,
> but I had hoped to find ways to minimize the vserver patch by reusing
> some of the LSM infrastructure. 

That is my biggest issue, too.  I really want vserver, but
I don't want to carry around a patch that's any larger than
it needs to be ;)

> The biggest issue was the ability to virtualize the results of something
> like the hostname to be ctx specific, which was deemed too much to do
> for the LSM interfaces.

Yup, that is indeed too much for the LSM interface;  because
of that additional things would seem needed.

> > 4) I'm all for generalising the interface, how about sys_virtual_context ?
> 
> I _think_ this can be done with /proc/[pid]/attr/.  This allows you to
> set the security attributes of a process. 

> http://mail.wirex.com/pipermail/linux-security-module/2003-April/4264.html       

Ohhhhhh.  I will need to check this out.  Thanks for the
information.  I've asked some selinux people whether there
was functionality like this and they didn't think so. Good
to see there is something after all ;)

I'll look at this in more detail to see whether it would
be enough to implement virtual host functionality.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

