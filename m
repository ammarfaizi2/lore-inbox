Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262392AbSJ0NkL>; Sun, 27 Oct 2002 08:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbSJ0NkL>; Sun, 27 Oct 2002 08:40:11 -0500
Received: from ns.suse.de ([213.95.15.193]:22546 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262392AbSJ0NkK> convert rfc822-to-8bit;
	Sun, 27 Oct 2002 08:40:10 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Posix capabilities
Date: Sun, 27 Oct 2002 14:46:24 +0100
User-Agent: KMail/1.4.3
References: <20021016154459.GA982@TK150122.tuwien.teleweb.at> <20021017122056.GB13573@think.thunk.org> <20021020141647.GB6280@elf.ucw.cz>
In-Reply-To: <20021020141647.GB6280@elf.ucw.cz>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210271446.24655.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 October 2002 16:16, Pavel Machek wrote:
> Hi!
>
> > > Ah, ok... I thought that things work like this: the capabilities
> > > support already is in the kernel, and to give an app a particular
> > > capability, one has to add a particalar extended attribute to the
> > > application executable. So I'm wrong here it seems?
> >
> > First of all, you can't use a standard user extended attribute, since
> > anyone with write access to the file will be allowed to set the
> > extended attribute.  This isn't good if you're going to be granting
>
> What are extended attributes good for, then?

Extended attributes support different namespaces, like user.* and system.*. 
The user.* namespace is treaded similarly to the file contents permission 
wise, so users can associate attributes with files. Things like ACLs, 
Capabilities, etc. are intended to be added to the system.* namespace. They 
differ from user.* in that they require different permissions/capabilities 
from the calling process.

ACLs are named system.posix_acl_access and system.posix_acl_default. 
Capabilities could be named system.posix_caps, for example.

You can look this all up in the attr(5) manual page at 
<http://acl.bestbits.at/cgi-man/attr.5>.

--Andreas.
