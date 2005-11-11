Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbVKKXdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbVKKXdP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 18:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbVKKXdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 18:33:15 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:85 "EHLO pfepc.post.tele.dk")
	by vger.kernel.org with ESMTP id S1751316AbVKKXdP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 18:33:15 -0500
Date: Sat, 12 Nov 2005 00:34:23 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       paulus@samba.org, anton@samba.org, linuxppc64-dev@ozlabs.org
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-ID: <20051111233423.GB28276@mars.ravnborg.org>
References: <20051107200336.GH3847@stusta.de> <20051110042857.38b4635b.akpm@osdl.org> <20051111021258.GK5376@stusta.de> <20051110182443.514622ed.akpm@osdl.org> <20051111201849.GP5376@stusta.de> <20051111132443.04061d10.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051111132443.04061d10.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2005 at 01:24:43PM -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > > > > 
> > > > > Sorry, I need to build allmodconfig kernels on wacky architectures (eg
> > > > > ppc64) and this patch is killing me.
> > > > 
> > > > Can you send me the list of compile errors so that I can work on fixing 
> > > > them?
> > > > 
> > > 
> > > No handily, sorry.   Missing virt_to_bus() is the typical problem.
> > >
> > 
> > But in this case -Werror-implicit-function-declaration doesn't create 
> > new compile errors, it only moves compile errors from compile time to 
> > link or depmod time - which is IMHO not a bad change.
> 
> It is a quite inconvenient change if you want to get full coverage with
> `make allmodconfig'.

It could be a Kconfig item if enabled or not.
Then you could use the new mechanishm in kconfig to disable it for your
allmodconfig builds.

cat allmod.config
CONFIG_CC_ERROR_IMPLICIT_FUNCTION_DECLARATION = 0


That should do the trick, but maybe too inconvinient??

	Sam
