Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422636AbWCIQcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422636AbWCIQcZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 11:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422638AbWCIQcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 11:32:25 -0500
Received: from xenotime.net ([66.160.160.81]:10424 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1422636AbWCIQcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 11:32:25 -0500
Date: Thu, 9 Mar 2006 08:34:12 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: tilman@imap.cc, linux-usb-devel@lists.sourceforge.net, hjlipp@web.de,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH] reduce syslog clutter (take 2)
Message-Id: <20060309083412.95e145ea.rdunlap@xenotime.net>
In-Reply-To: <20060309030257.5c1e0f30.akpm@osdl.org>
References: <440F609F.8090604@imap.cc>
	<20060309030257.5c1e0f30.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2006 03:02:57 -0800 Andrew Morton wrote:

> Tilman Schmidt <tilman@imap.cc> wrote:
> >
> > The current versions of the err() / info() / warn() syslog macros
> >  insert __FILE__ at the beginning of the message, which expands to
> >  the complete path name of the source file within the kernel tree.
> > 
> >  With the following patch, when used in a module, they'll insert the
> >  module name instead, which is significantly shorter and also tends to
> >  be more useful to users trying to make sense of a particular message.
> 
> Personally, I prefer to see filenames.  Or function names.  Sometimes it's
> rather unobvious how to go from module name to filename, due to a) multiple
> .o files being linked together, b) subsystems which insist on #including .c
> files in .c files (usb...) and c) the module system's cute habit of
> replacing underscores with dashes in module names.

True, just using module->name or whatever means that we would
(often?) have to do a lookup to see what source file it was in.

---
~Randy
