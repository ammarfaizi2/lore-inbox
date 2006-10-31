Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161458AbWJaBOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161458AbWJaBOR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 20:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161531AbWJaBOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 20:14:17 -0500
Received: from quickstop.soohrt.org ([85.131.246.152]:49624 "EHLO
	quickstop.soohrt.org") by vger.kernel.org with ESMTP
	id S1161458AbWJaBOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 20:14:17 -0500
Date: Tue, 31 Oct 2006 02:14:16 +0100
From: Horst Schirmeier <horst@schirmeier.com>
To: Andi Kleen <ak@suse.de>
Cc: Oleg Verych <olecom@flower.upol.cz>, Valdis.Kletnieks@vt.edu,
       Jan Beulich <jbeulich@novell.com>, dsd@gentoo.org, kernel@gentoo.org,
       draconx@gmail.com, jpdenheijer@gmail.com, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] replacement for broken kbuild-dont-put-temp-files-in-the-source-tree.patch
Message-ID: <20061031011416.GG2933@quickstop.soohrt.org>
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	Oleg Verych <olecom@flower.upol.cz>, Valdis.Kletnieks@vt.edu,
	Jan Beulich <jbeulich@novell.com>, dsd@gentoo.org,
	kernel@gentoo.org, draconx@gmail.com, jpdenheijer@gmail.com,
	Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <20061029120858.GB3491@quickstop.soohrt.org> <slrnekcu6m.2vm.olecom@flower.upol.cz> <20061031001235.GE2933@quickstop.soohrt.org> <200610310119.10567.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610310119.10567.ak@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2006, Andi Kleen wrote:
> 
> > The problem is, this brings us back to the problem where this whole
> > patch orgy began: Gentoo Portage sandbox violations when writing (the
> > null symlink) to the kernel tree when building external modules. What
> > about using $(M) as a base directory if it is defined?
> 
> I think Jan's $(objdir)/.tmp proposal would be cleanest. Just someone
> has to implement it :)
> 
> -Andi

I'm not sure what you mean by $(objdir); I just got something to work
which creates the /dev/null symlink in a (newly created if necessary)
directory named

$(firstword $(obj-dirs) $(M))/.tmp

which seems to be a good place for both normal kernel builds and
external modules. External module builds seem not to set $(obj-dirs)...
Objections?

Kind regards,
 Horst

-- 
PGP-Key 0xD40E0E7A
