Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264909AbUFWFvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264909AbUFWFvQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 01:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265716AbUFWFvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 01:51:16 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:20841 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S264909AbUFWFpm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 01:45:42 -0400
Date: Wed, 23 Jun 2004 07:57:57 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kbuild: Improve Kernel build with separated output
Message-ID: <20040623055757.GA2848@mars.ravnborg.org>
Mail-Followup-To: Ricky Beam <jfbeam@bluetronic.net>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel Mail List <linux-kernel@vger.kernel.org>
References: <20040622212100.GA9346@mars.ravnborg.org> <Pine.GSO.4.33.0406221749270.25702-100000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0406221749270.25702-100000@sweetums.bluetronic.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 06:04:28PM -0400, Ricky Beam wrote:
> On Tue, 22 Jun 2004, Sam Ravnborg wrote:
> >1) A Makefile is generated in the output directory allowing
> >   one to execute make in both the source and the output directory.
> 
> I would vote against doing that.  Or at the very least don't overwrite one
> that might already be there.  I, for one, have a very specific makefile in
> my build (object) directories.  Anyone sufficiently skilled to be building
> kernels outside the source tree, and/or those with the specific need to be
> doing so will already have makefiles and/or shell scripts to suit their
> needs.  Making the option a user specified target ala "make makefiles"
> would be a better/safer choice; if the user wants or needs a makefile in
> their object directory, then they have a simple option to make themselves
> one -- no knowledge of GNU Make necessary.

You cold just rename your Makefile to makefile. Then GNU Make will select that one
as first choice.

Today kbuild unconditionally overwrite the Makefile, because it depends on the following:
- Top level Makefile (VERSION)
- scripts/mkmakefile script
- Source directory
- Output directory

In total too many factors to check for so the more brutal approach used.

Do you use your specific Makefile for something others could benefit from?

	Sam
