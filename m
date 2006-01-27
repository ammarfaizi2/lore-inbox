Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWA0Oay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWA0Oay (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 09:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWA0Oay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 09:30:54 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:29128 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751238AbWA0Oay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 09:30:54 -0500
Date: Fri, 27 Jan 2006 15:30:52 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel manual pages
Message-ID: <20060127143052.GF3673@harddisk-recovery.com>
References: <20060127092623.GA7882@kestrel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127092623.GA7882@kestrel>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 10:26:23AM +0100, Karel Kulhavy wrote:
> Who is responsible for writing the linux kernel manual pages?  I went to
> vger.kernel.org and there is "There is much information about Linux on
> the web." which points to 7 different 3rd party websites.  I searched
> for "manual" and "manpage" in all 7 and didn't find any mention of
> manual pages.

The manpage editor, which is a completely different project than the
linux kernel itself. The manual pages are usually edited by the
distributions, so use the package manager for your distribution figure
out which manpage they belong to and file a patch/bug for the pages you
(dis)like:

  dpkg -S /usr/share/man/man4/ttyS.4.gz (debian based distros)
  rpm -qf /usr/share/man/man4/ttyS.4.gz (rpm based distros)

The distribution maintainer should take care of submitting the changes
upstream.

> I also suggest the http://kernel.org/links.html to be structured
> according to topic, and not according to name of the website. Because
> if the user comes, he mostly needs to know information about particular
> topic. This way he doesn't know which link to click to obtain the
> information.

Kernel.org is for distribution of the linux kernel for use by
developers and advanced users. Joe Random User shouldn't be compiling
his kernel in the first place, so making kernel.org "user friendly"
doesn't serve any purpose. The amount of links on that particular page
also doesn't really need a structure, even Joe Random User would be
able to navigate it.

> Furthermore I suggest "Manuals" section to be added to vger.kernel.org
> in the style OpenBSD has:
> http://openbsd.org/
> http://www.openbsd.org/cgi-bin/man.cgi

Manpages are userland stuff and therefore do not belong on kernel.org.
The kernel is documented in the Documentation/ directory in the source
tree, and ultimately in the source itself.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
