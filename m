Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWDRUV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWDRUV0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 16:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWDRUV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 16:21:26 -0400
Received: from [81.2.110.250] ([81.2.110.250]:20397 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932304AbWDRUVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 16:21:25 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Crispin Cowan <crispin@novell.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, James Morris <jmorris@namei.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
In-Reply-To: <44453E7B.1090009@novell.com>
References: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com>
	 <1145381250.19997.23.camel@jackjack.columbia.tresys.com>
	 <44453E7B.1090009@novell.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 18 Apr 2006 21:26:09 +0100
Message-Id: <1145391969.21723.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-04-18 at 12:31 -0700, Crispin Cowan wrote:
> implements an approximation to the AppArmor security model, but does it
> with domains and types instead of path names, imposing a substantial
> cost in ease-of-use on the user.

I don't think thats true. A file name is a pretty meaningless object in
Unixspace let alone Linux after Al Plan9ified it somewhat. It has an
impact on policy design but if anything it makes it slightly harder for
the policy design work and _easier_ for users, who no longer have to
follow magic path rules.

If you think about it, what matters is the object not the name. Who
cares what a 'cool executable' file from the internet is called. If I'm
doing policy for a large corporate then I wan't it not to be executable
unless someone has blessed it. It can be in /tmp in a users home
directory or in /var/spool/mail. Either way I don't care what it is
called just what it *is*.

Can you answer the "when are you submitting it upstream" question ? I've
certainly not got any fundamental objection to another security system.
I doubt we'd all use it but we don't all use sys5 file systems or
reiserfs either.

Alan

