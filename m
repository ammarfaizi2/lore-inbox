Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWDRXKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWDRXKG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 19:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWDRXKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 19:10:06 -0400
Received: from victor.provo.novell.com ([137.65.250.26]:14994 "EHLO
	victor.provo.novell.com") by vger.kernel.org with ESMTP
	id S1750808AbWDRXKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 19:10:02 -0400
Message-ID: <4445719E.8020300@novell.com>
Date: Tue, 18 Apr 2006 16:09:18 -0700
From: Crispin Cowan <crispin@novell.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Karl MacMillan <kmacmillan@tresys.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
References: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com>  <1145381250.19997.23.camel@jackjack.columbia.tresys.com>  <44453E7B.1090009@novell.com> <1145391969.21723.41.camel@localhost.localdomain> <444552A7.2020606@novell.com> <Pine.LNX.4.64.0604181709160.28128@d.namei>
In-Reply-To: <Pine.LNX.4.64.0604181709160.28128@d.namei>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:
> On Tue, 18 Apr 2006, Crispin Cowan wrote:
>   
>> SELinux has NSA legacy, and that is reflected in their inode design: it
>> is much better at protecting secrecy, which is the NSA's historic
>> mission.
>>     
> No.  The inode design is simply correct.
>   
"Correct" for what? inode access control is correct if data secrecy is
your number one objective. It is not necessarily correct for other purposes.

> Consider the following:
>
> What if Unix DAC security was implemented via pathnames, using a 
> configuration file and regexp matching enginer in the kernel, invoked 
> during file access, rather than the existing scheme of checking inode 
> ownership and permission attributes?
>   
What of it? That sounds very close to the AppArmor design, except for
the "discretionary" part. Just what is wrong with it? If your main
complaint is that you would miss having chmod and umask, then I agree:
we are not proposing to remove classic DAC. So what's your point?

> SELinux labels objects directly because it's the right thing to do.
>   
Security design by Wilford Brimley: emphatic assertion :)

AppArmor is a fully functional access control system that works on
pathname-based access controls. I'm sorry if it violates your religion
for it to exist and work. Claiming that pathname-based access control is
"broken" or "wrong" is about as useful as standing at Kitty Hawk in 1903
exclaiming that heavier-than-air flight is impossible. You don't have to
like it, but denying its existence is nonsense.

> To also clarify: the legacy of SELinux is in the decades of research 
> performed into providing more comprehensive security than the original 
> secrecy-oriented TCSEC schemes.  And conflating a highly loaded term such 
> as "NSA's historic mission" with an implementation specific aspect of 
> SELinux is useless in a technical discussion and IMHO totally 
> inappropriate.
>   
It is totally appropriate because it goes to the core reason for the
design difference between AppArmor and SELinux. The NSA, and indeed all
intelligence agencies, have secrecy as their #1 security need. inode
labels is absolutely the right way to achieve that.

However, I assert (emphatically :) that the broader user community has
integrity and availability as higher priorities than secrecy, and that
pathname-based access control is a better way to achieve that. I want to
offer Linux users the choice of pathname-based access control if they
want it. Why do you want to prevent them from having that choice?

Crispin
-- 
Crispin Cowan, Ph.D.                      http://crispincowan.com/~crispin/
Director of Software Engineering, Novell  http://novell.com

