Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759022AbWLDDAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759022AbWLDDAo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 22:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759033AbWLDDAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 22:00:44 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:3198 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1758999AbWLDDAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 22:00:43 -0500
Date: Sun, 3 Dec 2006 19:00:56 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Corey Minyard <minyard@acm.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>,
       Joseph Barnett <jbarnett@motorola.com>
Subject: Re: [PATCH 9/12] IPMI: add pigeonpoint poweroff
Message-Id: <20061203190056.2d8b3540.randy.dunlap@oracle.com>
In-Reply-To: <45738959.1000209@acm.org>
References: <20061202043746.GE30531@localdomain>
	<20061203132618.d7d58f59.akpm@osdl.org>
	<45738959.1000209@acm.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Dec 2006 20:35:05 -0600 Corey Minyard wrote:

> Andrew Morton wrote:
> > On Fri, 1 Dec 2006 22:37:46 -0600
> > Corey Minyard <minyard@acm.org> wrote:
> >
> >   
> >> +static void (*atca_oem_poweroff_hook)(ipmi_user_t user) = NULL;
> >>     
> >
> > Sometime, please go through the IPMI code looking for all these
> > statically-allocated things which are initialised to 0 or NULL and remove
> > all those intialisations?  They're unneeded, they increase the vmlinux
> > image size and there are quite a number of them.  Thanks.
> >   
> I'll do that, thanks, and I'll work on the other changes you suggest.

BTW, how about killing this comment or at least the email address part of it:

ipmi_bt_sm.c: *  Author:        Rocky Craig <first.last@hp.com>

---
~Randy
