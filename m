Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVG2AOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVG2AOH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 20:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVG2AOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 20:14:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26066 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261583AbVG2AOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 20:14:05 -0400
Date: Thu, 28 Jul 2005 17:12:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: george@mvista.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI watch dog notify patch
Message-Id: <20050728171251.78a535a7.akpm@osdl.org>
In-Reply-To: <42E97133.8060307@mvista.com>
References: <42E940BE.3020908@mvista.com>
	<20050728161341.15bf9625.akpm@osdl.org>
	<42E97133.8060307@mvista.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger <george@mvista.com> wrote:
>
> Andrew Morton wrote:
> > George Anzinger <george@mvista.com> wrote:
> > 
> >>	This patch adds a notify to the nmi watchdog to notify that
> >> 	the system is about to be taken down by the watchdog.  If the
> >> 	notify is handled with a NOTIFY_STOP return, the system is
> >> 	given a new lease on life.
> > 
> > 
> > It looks sensible, but as there aren't actually any in-kernel uses for this
> > I'd have thought it would be better for it to live out-of-tree?
> 
> I should just bundle it with the kgdb patch then?

I spose so, for now.  If kdb and/or nlkd could benefit from it then it
might simplify life to merge it into mainline.  Perhaps you could ping
Keith Owens <kaos@sgi.com> and clyde.griffin@novell.com?

