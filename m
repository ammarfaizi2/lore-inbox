Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262309AbVEMIel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbVEMIel (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 04:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVEMIe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 04:34:27 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:32271 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262306AbVEMIeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 04:34:17 -0400
To: bulb@ucw.cz
CC: hbryan@us.ibm.com, ericvh@gmail.com, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com
In-reply-to: <20050513071924.GA9667@vagabond> (message from Jan Hudec on Fri,
	13 May 2005 09:19:24 +0200)
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
References: <OF1BD633A3.AED1499B-ON88256FFF.006E4A76-88256FFF.00742B3D@us.ibm.com> <E1DWT0t-0000of-00@dorka.pomaz.szeredi.hu> <20050513071924.GA9667@vagabond>
Message-Id: <E1DWVby-0000zz-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 13 May 2005 10:33:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > You could argue about the usefulness of ptrace.  The point is, that
> > suid/sgid programs _can_ be discerned, and ptrace _needs_ to discern
> > them.
> 
> I actually neither needs to, nor does. For ptrace the definition is:
>     If the tracee has different privilegies, than the tracer, than it
>     can't be traced.

Right.  I was talking about suid/sgid because with private namespaces
(unless there's a way to enter them externally) only suid/sgid
programs will have different privileges.

> For this definition, the check is not a hack. It's the only way to go.
> 
> Now this definition is really what is needed for the filesystem case
> too, so I think it's not a hack either. 

Fully agreed.

Miklos
