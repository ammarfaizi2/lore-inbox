Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264974AbUD3Aer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264974AbUD3Aer (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 20:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265034AbUD3Aer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 20:34:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:14475 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264974AbUD3Aeq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 20:34:46 -0400
Date: Thu, 29 Apr 2004 17:32:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Isaacson <adi@hexapodia.org>
Cc: pj@sgi.com, vonbrand@inf.utfsm.cl, nickpiggin@yahoo.com.au,
       jgarzik@pobox.com, brettspamacct@fastclick.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-Id: <20040429173223.3ea4d0c5.akpm@osdl.org>
In-Reply-To: <20040430000408.GA29096@hexapodia.org>
References: <40904A84.2030307@yahoo.com.au>
	<200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>
	<20040429133613.791f9f9b.pj@sgi.com>
	<20040429141947.1ff81104.akpm@osdl.org>
	<20040429143403.35a7a550.pj@sgi.com>
	<20040429145725.267ea7b8.akpm@osdl.org>
	<20040430000408.GA29096@hexapodia.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson <adi@hexapodia.org> wrote:
>
>  But in a related case, I have a background daemon that does a lot of IO
>  (mostly sequential, one page at a time read/modify/write of a multi-GB
>  file) to a filesystem on a separate spindle from my main filesystems.
>  I'd like to use a similar mechanism to say "don't let this program eat
>  my pagecache" that will let the daemon crunch away without severely
>  impacting my desktop work.

fadvise(POSIX_FADV_DONTNEED) is ideal for this.  Run it once per megabyte
or so.
