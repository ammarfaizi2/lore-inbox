Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751826AbWCILFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbWCILFF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 06:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbWCILFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 06:05:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15282 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751826AbWCILFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 06:05:02 -0500
Date: Thu, 9 Mar 2006 03:02:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tilman Schmidt <tilman@imap.cc>
Cc: linux-usb-devel@lists.sourceforge.net, hjlipp@web.de,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH] reduce syslog clutter (take 2)
Message-Id: <20060309030257.5c1e0f30.akpm@osdl.org>
In-Reply-To: <440F609F.8090604@imap.cc>
References: <440F609F.8090604@imap.cc>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tilman Schmidt <tilman@imap.cc> wrote:
>
> The current versions of the err() / info() / warn() syslog macros
>  insert __FILE__ at the beginning of the message, which expands to
>  the complete path name of the source file within the kernel tree.
> 
>  With the following patch, when used in a module, they'll insert the
>  module name instead, which is significantly shorter and also tends to
>  be more useful to users trying to make sense of a particular message.

Personally, I prefer to see filenames.  Or function names.  Sometimes it's
rather unobvious how to go from module name to filename, due to a) multiple
.o files being linked together, b) subsystems which insist on #including .c
files in .c files (usb...) and c) the module system's cute habit of
replacing underscores with dashes in module names.

