Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbTKQNJY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 08:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263490AbTKQNJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 08:09:24 -0500
Received: from pix-525-pool.redhat.com ([66.187.233.200]:23185 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263487AbTKQNJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 08:09:22 -0500
Date: Mon, 17 Nov 2003 08:08:06 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Adrian Bunk <bunk@fs.tum.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] disallow modular BINFMT_ELF
Message-ID: <20031117130806.GC6288@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20031115232600.GF7919@fs.tum.de> <3FB6BB35.8090001@pobox.com> <m1vfpjol6w.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1vfpjol6w.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 16, 2003 at 06:09:11PM -0700, Eric W. Biederman wrote:
> Jeff Garzik <jgarzik@pobox.com> writes:
> 
> > Adrian Bunk wrote:
> > > modular BINFMT_ELF gives unresolved symbols in 2.4 .
> > > modular BINFMT_ELF gives the following unresolved symbols in 2.6:
> > 
> > 
> > Interesting.  this causes me to wonder if we should bother making BINFMT_ELF an
> > 
> > option at all...
> 
> We have platforms uClinux for which ELF is not the preferred format so we
> should at least be able to compile it out.

Similarly on bi-arch supporting platforms, CONFIG_BINFMT_ELF controls
64-bit ELF support which one might want to disable and only use
CONFIG_BINFMT_ELF32 (or other config option which controls 32-bit ELF
support).

	Jakub
