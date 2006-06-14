Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWFNEUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWFNEUU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 00:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWFNEUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 00:20:20 -0400
Received: from 1wt.eu ([62.212.114.60]:39176 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751214AbWFNEUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 00:20:19 -0400
Date: Wed, 14 Jun 2006 06:20:08 +0200
From: Willy Tarreau <w@1wt.eu>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Avuton Olrich <avuton@gmail.com>, Russell Whitaker <russ@ashlandhome.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16.19 + gcc-4.1.1
Message-ID: <20060614042007.GD13255@w.ods.org>
References: <Pine.LNX.4.63.0606131906230.2368@bigred.russwhit.org> <3aa654a40606132049u43f81ee1m263ee15666246152@mail.gmail.com> <448F8C53.5010406@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448F8C53.5010406@ens-lyon.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2006 at 12:10:59AM -0400, Brice Goglin wrote:
> Avuton Olrich wrote:
> > On 6/13/06, Russell Whitaker <russ@ashlandhome.net> wrote:
> >> Then, after mrproper, rebuilt with gcc-4.1.1, no other changes.
> >>    compiles ok, installs ok. But, when attempting to load a module, get
> >>    the following message:  version magic '2.6.16.19via K6 gcc-4.1',
> >>    should be '2.6.16.19via 486 gcc-3.3'
> >
> > You may have forgotten to "make modules modules_install"
> 
> Actually, "make modules" does not exist anymore with 2.6. Both built-in
> and modular stuff are built at the same time.
> Only "make modules_install" is still required.

What's this bullshit ?

$ grep ^modules: Makefile
modules: $(vmlinux-dirs) $(if $(KBUILD_BUILTIN),vmlinux)
modules: $(module-dirs)

Avuton is right, you *have* forgotten to make modules.

> Brice

Willy

