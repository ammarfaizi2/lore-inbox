Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263705AbTICP5v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 11:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263793AbTICPzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 11:55:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:7648 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263705AbTICPzb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:55:31 -0400
Date: Wed, 3 Sep 2003 08:38:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniel Blueman <daniel.blueman@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pdflush question...
Message-Id: <20030903083840.768cfd58.akpm@osdl.org>
In-Reply-To: <14227.1062581053@www37.gmx.net>
References: <14227.1062581053@www37.gmx.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Blueman <daniel.blueman@gmx.net> wrote:
>
> Is it worth having a kernel config option to vary the number of 'pdflush'
> kernel threads?
> 
> For embedded, systems with no swap and maybe uniproc (?), perhaps one
> pdflush kthread would do?

Probably it should just be set to one by default anyway.  One pdflush is
good at serving lots of spindles.

> Perhaps more generally, the number could be linked to the number of
> processors and/or swap devices or spindles- this would eliminate having to configure
> it, and improve downward and upward scaling, perhaps?

Well the kernel will create up to eight pdflush instances according to the
current load.  That kinda works.

