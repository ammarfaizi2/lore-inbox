Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWFQVGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWFQVGz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 17:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbWFQVGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 17:06:55 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:24471 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750904AbWFQVGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 17:06:54 -0400
Date: Sat, 17 Jun 2006 23:06:50 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Greg KH <greg@kroah.com>
Cc: Jan Beulich <jbeulich@novell.com>, linux-kernel@vger.kernel.org,
       Ram Pai <linuxram@us.ibm.com>
Subject: Re: GPL-only symbols issue
Message-ID: <20060617210650.GA9243@mars.ravnborg.org>
References: <445F0B6F.76E4.0078.0@novell.com> <20060509042500.GA4226@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509042500.GA4226@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 09:25:00PM -0700, Greg KH wrote:
> On Mon, May 08, 2006 at 09:12:15AM +0200, Jan Beulich wrote:
> > Sam,
> > 
> > would it seem reasonable a request to detect imports of GPL-only
> > symbols by non-GPL modules also at build time rather than only at run
> > time, and at least warn about such?
> 
> Ram has some tools that might catch this kind of thing.  He's posted his
> scripts to lkml in the past, try looking in the archives.

Responding to an old post here.

I have only recently integrated Ram's patches except for the kbuild
integration bits. On top of this Andreas' license compatibility thing so
in effect:
building a GPL module (or compatible) => no change
building a GPL-incompatible module =>
                           warn if module uses EXPORT_SYMBOL_GPL_FUTURE
                           error out if module uses EXPORT_SYMBOL_GPL

Patches are in kbuild.git.
The script to show module export statistics is not yet merged, I've
asked Ram to fix a few things first.

	Sam
