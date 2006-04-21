Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWDUVij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWDUVij (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 17:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWDUVii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 17:38:38 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:26934 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964774AbWDUVih convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 17:38:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V8xWVfgkmKvN/JO1tMrh8ndFxbd2g0c6dh7+Hllb3yfj9Tkj6vxFEXJ1+VMjiq5oSNKdfFTXSIGfyjYK3NPK/Xf52ySvkyNZcAro/s14DG0jJr8AIf4/Xl+ciuFGB7E8T2EHVFMSZZ8BJUXwsrc0DjAUUAh1fn0ui3q3qkvBwt4=
Message-ID: <161717d50604211438h2f6f768fgf1e8466065802b5e@mail.gmail.com>
Date: Fri, 21 Apr 2006 17:38:37 -0400
From: "Dave Neuer" <mr.fred.smoothie@pobox.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Cc: Valdis.Kletnieks@vt.edu, "Chris Wright" <chrisw@sous-sol.org>,
       "James Morris" <jmorris@namei.org>,
       "Arjan van de Ven" <arjan@infradead.org>, "Andi Kleen" <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <1145651704.21749.305.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <1145470463.3085.86.camel@laptopd505.fenrus.org>
	 <p73mzeh2o38.fsf@bragg.suse.de>
	 <1145522524.3023.12.camel@laptopd505.fenrus.org>
	 <20060420192717.GA3828@sorel.sous-sol.org>
	 <1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil>
	 <20060421173008.GB3061@sorel.sous-sol.org>
	 <1145642853.21749.232.camel@moss-spartans.epoch.ncsc.mil>
	 <200604212006.k3LK6LtH015500@turing-police.cc.vt.edu>
	 <1145651704.21749.305.camel@moss-spartans.epoch.ncsc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/06, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> IIUC, AppArmor does impose such constraints, but only from the
> perspective of an individual program's profile.  Upon link(2), they
> check that the program had link permission to the old link name and that
> both the old link name and new link name have consistent permissions in
> the profile, and they prohibit or limit by capability the ability to
> manipulate the namespace by confined programs.  But this doesn't mean
> that another program running under a different profile can't create such
> a link (if allowed to do so by its profile, of course), or that an
> unconfined process cannot do so.  There is no real "system policy" or
> system-wide security properties with AppArmor; you can only look at it
> in terms of individual programs (which themselves are identified by path
> too).
>
> > However, I'll say up front that such an argument would only suffice to
> > move it from "broken" to "very brittle in face of changes" (for instance,
> > would such a hardlink restriction cause collateral damage that an attacker
> > could exploit?  How badly does it fail in the face of a misdesigned policy?)
>
> Indeed.  I think Thomas Bleher made a good assessment of it in:
> https://lists.ubuntu.com/archives/ubuntu-hardened/2006-March/000143.html

But what about Dr. Cowan's response at:
https://lists.ubuntu.com/archives/ubuntu-hardened/2006-March/000144.html

In particular, if you don't trust your users, why do you give them the
ability to create links?

Dave
