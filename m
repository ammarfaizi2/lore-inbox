Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264842AbUEJQA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264842AbUEJQA3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 12:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264840AbUEJQA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 12:00:29 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:41108 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264842AbUEJQAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 12:00:11 -0400
Date: Mon, 10 May 2004 17:59:58 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
       Pavel Machek <pavel@ucw.cz>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
Message-ID: <20040510155958.GD16182@wohnheim.fh-wedel.de>
References: <20040506131731.GA7930@wohnheim.fh-wedel.de> <m1pt9clv62.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m1pt9clv62.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 May 2004 23:15:33 -0600, Eric W. Biederman wrote:
> Jörn Engel <joern@wohnheim.fh-wedel.de> writes:
> > 3 copyfile		- new copyfile() system call
> > http://wohnheim.fh-wedel.de/~joern/cowlink/
> 
> Question about sys_copyfile.
> 
> Is the intention that a new file with completely new permissions
> be created?
> 
> Some people have wanted a copyfile that copies all of the extra
> metadata user/group/acls.
> 
> I currently see technical merit in both approaches.
> 
> Looking at the CIFS information it appears that the CopyFILE RPC
> copies the permissions.  It is not at all clear about that, and
> the fact it appears to copy permissions may simply be a specification
> bug.  Given that FAT does not really have permissions, let alone
> extended attributes it would be an easy mistake to make.
> 
> In the general case you cannot copy permissions from one file to
> another, either you don't have those permissions yourself or the
> target file system may not support them all.  Not copying
> permissions leads to a simpler implementation with the burden
> of the work left to user space.  What is not done is a loop through
> the extended attributes.

Unless someone finds a good reason to change this, I prefer to create
new permissions and not copy the acl's.  That way, I can also
copyfile() a file belonging to someone else, as long as I have read
access to it.

Jörn

-- 
Don't worry about people stealing your ideas. If your ideas are any good,
you'll have to ram them down people's throats.
-- Howard Aiken quoted by Ken Iverson quoted by Jim Horning quoted by
   Raph Levien, 1979
