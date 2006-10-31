Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423254AbWJaNpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423254AbWJaNpP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 08:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423257AbWJaNpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 08:45:14 -0500
Received: from raven.upol.cz ([158.194.120.4]:38886 "EHLO raven.upol.cz")
	by vger.kernel.org with ESMTP id S1423254AbWJaNpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 08:45:13 -0500
Date: Tue, 31 Oct 2006 14:51:36 +0100
To: Horst Schirmeier <horst@schirmeier.com>, Andi Kleen <ak@suse.de>,
       Valdis.Kletnieks@vt.edu, Jan Beulich <jbeulich@novell.com>,
       dsd@gentoo.org, kernel@gentoo.org, draconx@gmail.com,
       jpdenheijer@gmail.com, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] replacement for broken kbuild-dont-put-temp-files-in-the-source-tree.patch
Message-ID: <20061031135136.GB16063@flower.upol.cz>
References: <20061029120858.GB3491@quickstop.soohrt.org> <slrnekcu6m.2vm.olecom@flower.upol.cz> <20061031001235.GE2933@quickstop.soohrt.org> <200610310119.10567.ak@suse.de> <20061031011416.GG2933@quickstop.soohrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061031011416.GG2933@quickstop.soohrt.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 02:14:16AM +0100, Horst Schirmeier wrote:
> On Tue, 31 Oct 2006, Andi Kleen wrote:
> > 
> > > The problem is, this brings us back to the problem where this whole
> > > patch orgy began: Gentoo Portage sandbox violations when writing (the
> > > null symlink) to the kernel tree when building external modules. What
> > > about using $(M) as a base directory if it is defined?
> > 
> > I think Jan's $(objdir)/.tmp proposal would be cleanest. Just someone
> > has to implement it :)
> > 
> > -Andi

$(objtree) here,

> I'm not sure what you mean by $(objdir); I just got something to work
> which creates the /dev/null symlink in a (newly created if necessary)
> directory named

$(objtree) is a directory for all possible outputs of the build precess,
it's set up by `O=' or `KBUILD_OUTPUT', and this is *not* output for ready
external modules `$(M)'. Try to play with this, please.

I'm looking for Sam to say something, if we must go further with this.
____
