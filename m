Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbWDGWNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbWDGWNi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 18:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWDGWNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 18:13:38 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:26304 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964997AbWDGWNh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 18:13:37 -0400
Date: Fri, 7 Apr 2006 17:13:34 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@sw.ru>, herbert@13thfloor.at, devel@openvz.org,
       sam@vilain.net, "Eric W. Biederman" <ebiederm@xmission.com>,
       xemul@sw.ru
Subject: Re: [RFC][PATCH 1/5] uts namespaces: Implement utsname namespaces
Message-ID: <20060407221334.GA25809@sergelap.austin.ibm.com>
References: <20060407095132.455784000@sergelap> <20060407183600.C8A8F19B8FD@sergelap.hallyn.com> <Pine.LNX.4.64.0604071645230.13532@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604071645230.13532@d.namei>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting James Morris (jmorris@namei.org):
> On Fri, 7 Apr 2006, Serge E. Hallyn wrote:
> 
> 
> > +EXPORT_SYMBOL(unshare_uts_ns);
> > +EXPORT_SYMBOL(free_uts_ns);
> 
> Why not EXPORT_SYMBOL_GPL?

Actually come to think of it they don't need to be exported.

I will move the exports to the last, debugging, patch.

> What do you expect the user api to look like, a syscall?

This remains to be determined, and this patchset purposely doesn't
address it.  AFAIU, the two most likely options are extending clone and
unshare, and using new syscalls.  Whatever is decided for the other
namespaces, this should use.

With this patchset (minus the last patch for debugging) uts namespaces
are supported, but processes can't clone their uts namespace yet.

> Probably need to think about LSM hooks for creating and updating the 
> namespaces.

True, that is something that needs to be discussed when the topic
of how to implement unsharing comes up again.

thanks,
-serge
