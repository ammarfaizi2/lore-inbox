Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVBHIfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVBHIfj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 03:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbVBHIfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 03:35:39 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:39403 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261484AbVBHIev
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 03:34:51 -0500
Subject: Re: [RFC][PATCH 2.6.11-rc3-mm1] Relay Fork Module
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
In-Reply-To: <20050207154623.33333cda.akpm@osdl.org>
References: <1107786245.9582.27.camel@frecb000711.frec.bull.fr>
	 <20050207154623.33333cda.akpm@osdl.org>
Date: Tue, 08 Feb 2005 09:34:45 +0100
Message-Id: <1107851685.8436.52.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 08/02/2005 09:43:22,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 08/02/2005 09:43:25,
	Serialize complete at 08/02/2005 09:43:25
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-07 at 15:46 -0800, Andrew Morton wrote: 
> Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
> >
> >    This module sends a signal to one or several processes (in user
> > space) when a fork occurs in the kernel. It relays information about
> > forks (parent and child pid) to a user space application.
> >
> > ...
> >    This patch is used by the Enhanced Linux System Accounting tool
> > that can be downloaded from http://elsa.sf.net
> 
> So this permits ELSA to maintain a complete picture of the
> process/thread hierarchy? 

Yes it does. 

> Implementation-wise: there's a lot of code there and the interface is
> a bit
> awkward.  Why not just feed that kobject you have there into
> kobject_uevent()?

There isn't good reason and as kobject_uevent is here to notify user
space application by sending event through the netlink interface we can
add a new event (KOBJ_FORK) and send the fork creation by using this
interface. I agree with your comment and I'm working on this solution.

Thank you very much for your help,
Regards,

Guillaume

