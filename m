Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751852AbWDDK63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbWDDK63 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 06:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbWDDK63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 06:58:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:14572 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751852AbWDDK62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 06:58:28 -0400
Date: Tue, 4 Apr 2006 12:58:26 +0200
From: Olaf Hering <olh@suse.de>
To: John Mylchreest <johnm@gentoo.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, paulus@samba.org
Subject: Re: [PATCH 1/1] POWERPC: Fix ppc32 compile with gcc+SSP in 2.6.16
Message-ID: <20060404105826.GA22820@suse.de>
References: <20060402085850.GA28857@suse.de> <20060402102259.GM16917@getafix.willow.local> <20060402102815.GA29717@suse.de> <20060402105859.GN16917@getafix.willow.local> <20060402111002.GA30017@suse.de> <20060402112002.GA3443@getafix.willow.local> <20060402114215.GA30491@suse.de> <20060404085729.GH3443@getafix.willow.local> <20060404094124.GA22332@suse.de> <20060404100115.GI3443@getafix.willow.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060404100115.GI3443@getafix.willow.local>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Apr 04, John Mylchreest wrote:

> On Tue, Apr 04, 2006 at 11:41:24AM +0200, Olaf Hering <olh@suse.de> wrote:
> > I think this should go into the main makefile, HOSTCFLAGS or similar. If
> > you look around quickly in the gentoo bugzilla, all non-userland
> > packages (grub, xen, kernel etc.) require the -fno-feature.
> 
> I'm not completely sure I understand where you are coming from here?
> I assume you mean adding -fno-stack-protector to the host userlands
> CFLAGS variable (or similar) to make it a global change, but if so
> you're missing my point.

I mean the whole kernel should be compiled with it, if you put it into
global cflags, the boot parts will pick it up from there.
