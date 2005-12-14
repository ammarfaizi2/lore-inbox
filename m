Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbVLNQ33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbVLNQ33 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 11:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbVLNQ33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 11:29:29 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:53189 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964828AbVLNQ32
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 11:29:28 -0500
Date: Wed, 14 Dec 2005 10:29:13 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Pavel Machek <pavel@ucw.cz>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Dave Hansen <haveblue@us.ibm.com>, "SERGE E. HALLYN" <serue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hubertus Franke <frankeh@watson.ibm.com>, Paul Jackson <pj@sgi.com>
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-ID: <20051214162913.GA22492@sergelap.austin.ibm.com>
References: <20051114212341.724084000@sergelap> <m1slt5c6d8.fsf@ebiederm.dsl.xmission.com> <1133977623.24344.31.camel@localhost> <m1hd9kd89y.fsf@ebiederm.dsl.xmission.com> <1133991650.30387.17.camel@localhost> <m18xuwd015.fsf@ebiederm.dsl.xmission.com> <20041214152325.GA2377@ucw.cz> <1134567609.9442.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134567609.9442.2.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arjan van de Ven (arjan@infradead.org):
> On Tue, 2004-12-14 at 15:23 +0000, Pavel Machek wrote:
> > Hi!
> > 
> > > One of my wish list items would be to run my things like my
> > > web browser in a container with only access to a subset of
> > > the things I can normally access.  That way I could be less
> > > concerned about the latest browser security bug.
> > 
> > subterfugue.sf.net (using ptrace), but yes, nicer solution
> > would be welcome.
> 
> selinux too, as well as andrea's syscall filter thing and many others.
> 
> the hardest is the balance between security and usability. You don't
> want your browser to be able to read files in your home dir (Except
> maybe a few selected ones in the browsers own dir)... until you want to
> upload a file via a webform.

Yup, right now I use a separate account (not in wheel) for web browsing,
which using Janak's unshare() patch and a small pam library gets its own
namespace which can't see my dmcrypted home partition and has private
/tmp.  File sharing is done through a non-standard tmp, just to prevent
scripts from using it.

Pretty convenient, but it really wants some stronger isolation.  You'd
think I'd at least use my bsdjail to keep unix sockets and such safe...

Anyway, real containers would indeed be far more convenient, or at least
prettier.  

-serge
