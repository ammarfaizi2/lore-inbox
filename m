Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265655AbUBBGVd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 01:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265659AbUBBGVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 01:21:32 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:26890 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S265655AbUBBGVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 01:21:31 -0500
Date: Mon, 2 Feb 2004 07:30:42 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: "kbuild-devel@lists.sourceforge.net" 
	<kbuild-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] External kernel modules
Message-ID: <20040202063042.GA2133@mars.ravnborg.org>
Mail-Followup-To: Andreas Gruenbacher <agruen@suse.de>,
	"kbuild-devel@lists.sourceforge.net" <kbuild-devel@lists.sourceforge.net>,
	lkml <linux-kernel@vger.kernel.org>
References: <1075701681.8018.66.camel@nb.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075701681.8018.66.camel@nb.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 02, 2004 at 07:01:21AM +0100, Andreas Gruenbacher wrote:
> I propose the attached patch: It adds symbol version dump/load
> functionality to modpost: When compiling the kernel, the module versions
> are dumped to a file. When compiling external modules, the dumped
> symbols are first loaded. Also, to allow a read-only kernel source tree
> and not interfere with the kernel sources, the .tmp_versions/ directory
> is placed in the external module's directory.
> 
> Furthermore, the patch adds clean/distclean/mrproper make targets with
> reasonable semantics for external modules, and also adds a modules_add
> target that installs the external modules into
> /lib/modules/$(KERNELRELEASE). (The modules_install target could be
> used, but it has different semantics, so I have used a different name
> instead.)

Thanks, I will take a closer look during the week.
Did you consider using the make O=dir support, so .tmp_versions were
created in the output directory?

	Sam
