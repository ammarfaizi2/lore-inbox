Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965112AbWHWTWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965112AbWHWTWi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 15:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965111AbWHWTWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 15:22:38 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:7302 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965014AbWHWTWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 15:22:37 -0400
Subject: Re: [PATCH 5/7] SLIM: make and config stuff
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
In-Reply-To: <1156360773.8506.103.camel@moss-spartans.epoch.ncsc.mil>
References: <1156359949.6720.69.camel@localhost.localdomain>
	 <1156360773.8506.103.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 12:22:37 -0700
Message-Id: <1156360957.6720.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-23 at 15:19 -0400, Stephen Smalley wrote:
> On Wed, 2006-08-23 at 12:05 -0700, Kylene Jo Hall wrote:
> > This patch contains the Makefile, Kconfig and .h files for SLIM.
> > 
> > Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
> > Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
> 
> > --- linux-2.6.18-rc3/security/slim/Kconfig	1969-12-31 18:00:00.000000000 -0600
> > +++ linux-2.6.18-rc3-working/security/slim/Kconfig	2006-08-04 13:29:13.000000000 -0500
> > @@ -0,0 +1,6 @@
> > +config SECURITY_SLIM
> > +	boolean "SLIM support"
> > +	depends on SECURITY && SECURITY_NETWORK && INTEGRITY
> 
> && !SECURITY_SELINUX?
> 
Rather it seems to make more sense to add an option to slim so that it
could be enabled/disabled on the boot line like selinux=0 and then they
can both be built but only one turned on at a time.

> > +	help
> > +	  The Simple Linux Integrity Module implements a modified low water-mark
> > +	  mandatory access control integrity model.
> 

