Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTGKONP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 10:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbTGKONH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 10:13:07 -0400
Received: from hermes.ex.ac.uk ([144.173.6.14]:49965 "EHLO hermes.ex.ac.uk")
	by vger.kernel.org with ESMTP id S262464AbTGKOM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 10:12:29 -0400
Subject: Re: 2.4.21 - minor config glitch
From: Alan Brady <Alan.C.Brady@exeter.ac.uk>
To: linux-kernel@vger.kernel.org
Cc: engebret@us.ibm.com
In-Reply-To: <20030711135716.GI10217@louise.pinerecords.com>
References: <1057924063.32461.61.camel@tactile.ex.ac.uk>
	 <20030711135716.GI10217@louise.pinerecords.com>
Content-Type: text/plain
Organization: 
Message-Id: <1057933696.32461.78.camel@tactile.ex.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Jul 2003 15:28:16 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-11 at 14:57, Tomas Szepe wrote:
> > [Alan.C.Brady@exeter.ac.uk]
> > 
> > Not a bug, but some apps choke when trying to parse the missing
> > condition. 
> > 
> > /usr/src/linux-2.4.21//drivers/char/Config.in, line 161:
> > 
> > 	if [ "$CONFIG_PPC64" ] ; then 
> >                    ^^^
> > 
> > I presume this should get set as
> >  
> > 	if [ "$CONFIG_PPC64" = "y" ] ; then
> 
> Would you post a -p1 patch, please?
> Don't forget to CC the PPC64 maintainer(s).

PATCH FOLLOWS

--- linux-2.4.21/drivers/char/Config.old        Fri Jun 13 15:51:32 2003
+++ linux-2.4.21/drivers/char/Config.in Fri Jul 11 15:12:21 2003
@@ -158,7 +158,7 @@
    dep_tristate 'Texas Instruments parallel link cable support'
CONFIG_TIPAR $CONFIG_PARPORT
 fi

-if [ "$CONFIG_PPC64" ] ; then
+if [ "$CONFIG_PPC64" = "y" ] ; then
    bool 'pSeries Hypervisor Virtual Console support' CONFIG_HVC_CONSOLE
 fi




-- 
Alan Brady <Alan.C.Brady@ex.ac.uk>

