Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbWIRUy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbWIRUy3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 16:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbWIRUy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 16:54:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5605 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964988AbWIRUy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 16:54:28 -0400
Date: Mon, 18 Sep 2006 16:54:12 -0400
From: Dave Jones <davej@redhat.com>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>, akpm@osdl.org
Subject: Re: [PATCH 4/7] SLIM: secfs patch
Message-ID: <20060918205412.GA2640@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Kylene Jo Hall <kjhall@us.ibm.com>,
	Stephen Smalley <sds@tycho.nsa.gov>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	LSM ML <linux-security-module@vger.kernel.org>,
	Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
	Serge Hallyn <sergeh@us.ibm.com>, akpm@osdl.org
References: <1158083873.18137.14.camel@localhost.localdomain> <1158611418.14194.70.camel@moss-spartans.epoch.ncsc.mil> <1158612642.16727.53.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158612642.16727.53.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2006 at 01:50:42PM -0700, Kylene Jo Hall wrote:

 > > > This patch provides the securityfs used by SLIM.

nitpick. (I never reviewed this when it was posted, but this followup
caught my eye..)

 > > > --- linux-2.6.18/security/slim/slm_secfs.c	1969-12-31 16:00:00.000000000 -0800
 > > > +++ linux-2.6.17-working/security/slim/slm_secfs.c	2006-09-06 11:49:09.000000000 -0700
 > > > @@ -0,0 +1,73 @@
 > > > +/*
 > > > + * SLIM securityfs support: debugging control files
 > > > + *
 > > > + * Copyright (C) 2005, 2006 IBM Corporation
 > > > + * Author: Mimi Zohar <zohar@us.ibm.com>
 > > > + *	   Kylene Hall <kjhall@us.ibm.com>
 > > > + *
 > > > + *      This program is free software; you can redistribute it and/or modify
 > > > + *      it under the terms of the GNU General Public License as published by
 > > > + *      the Free Software Foundation, version 2 of the License.
 > > > + */
 > > > +
 > > > +#include <asm/uaccess.h>
 > > > +#include <linux/config.h>

You don't need to include config.h any more, kbuild does it for you.
(Might want to check the other files for the same thing).

	Dave
