Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030484AbWD1Q3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030484AbWD1Q3O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 12:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030482AbWD1Q3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 12:29:13 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:48553 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030479AbWD1Q3M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 12:29:12 -0400
Date: Fri, 28 Apr 2006 11:29:04 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Ulrich Drepper <drepper@gmail.com>,
       Axelle Apvrille <axelle_apvrille@yahoo.fr>, Nix <nix@esperi.org.uk>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       disec-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for run-timeauthentication of binaries
Message-ID: <20060428162904.GB31473@sergelap.austin.ibm.com>
References: <87slo2nn0b.fsf@hades.wkstn.nix> <20060425161139.87285.qmail@web26109.mail.ukl.yahoo.com> <a36005b50604280833k5a811384r5f3a6f92dd707256@mail.gmail.com> <20060428160914.GA31473@sergelap.austin.ibm.com> <1146240670.3126.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146240670.3126.20.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arjan van de Ven (arjan@infradead.org):
> 
> > A one time effort to write it *and sign it*.
> you don't sign nor need to sign perl or bash scripts. Why would a loader
> be written in ELF itself? There's absolutely no reason for that.

Yup, that's an unfortunate shortcoming.  We'd been wanting to re-post to
lkml for a long time to get ideas to fix that.

I had an extension to digsig earlier which enabled signing shellscripts
using xattrs (just because it was a trivial task), but that's clearly
insufficient as it would catch "./myscript.pl" but not "perl
myscript.pl".

For now obviously the only thing to do is make sure that sensitive
accounts (i.e. accounts not severely restricted through selinux) can't
use anything but, say, rsh.  I assume this is what previous posters
using digsig do?

Anyone have any better ideas for properly handling shellscripts?

-serge
