Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262259AbVC2Mvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbVC2Mvc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 07:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbVC2Mvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 07:51:31 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:53394 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262259AbVC2Mv1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 07:51:27 -0500
Subject: Re: [patch 1/2] fork_connector: add a fork connector
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Paul Jackson <pj@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Jay Lan <jlan@engr.sgi.com>,
       Erich Focht <efocht@hpce.nec.com>, Ram <linuxram@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
In-Reply-To: <20050328134242.4c6f7583.pj@engr.sgi.com>
References: <1111745010.684.49.camel@frecb000711.frec.bull.fr>
	 <20050328134242.4c6f7583.pj@engr.sgi.com>
Date: Tue, 29 Mar 2005 14:51:15 +0200
Message-Id: <1112100675.8426.72.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/03/2005 15:01:00,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/03/2005 15:01:02,
	Serialize complete at 29/03/2005 15:01:02
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-28 at 13:42 -0800, Paul Jackson wrote:
> Guillaume wrote:
> >   The lmbench shows that the overhead (the construction and the sending
> > of the message) in the fork() routine is around 7%.
> 
> Thanks for including the numbers.  The 7% seems a bit costly, for a bit
> more accounting information.  Perhaps dean's suggestion, to not use
> ascii, will help.  I hope so, though I doubt it will make a huge
> difference.  Was this 7% loss with or without a user level program
> consuming the sent messages?  I would think that the number of interest
> would include a minimal consumer task.

I ran some test using the CBUS instead of the cn_netlink_send() routine
and the overhead is nearly 0%:

fork connector disabled:
    Process fork+exit: 148.1429 microseconds

fork connector enabled:
    Process fork+exit: 148.4595 microseconds

Regards,
Guillaume

