Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262653AbVAEXUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbVAEXUr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 18:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbVAEXUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 18:20:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:11500 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262653AbVAEXS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 18:18:27 -0500
Date: Wed, 5 Jan 2005 15:17:42 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] [resend] split bprm_apply_creds into two functions
Message-ID: <20050105151742.D2357@build.pdx.osdl.net>
References: <20050104183043.GA3592@IBM-BWN8ZTBWA01.austin.ibm.com> <20050104135210.X2357@build.pdx.osdl.net> <20050105144329.GA3304@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050105144329.GA3304@IBM-BWN8ZTBWA01.austin.ibm.com>; from serue@us.ibm.com on Wed, Jan 05, 2005 at 08:43:29AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Serge E. Hallyn (serue@us.ibm.com) wrote:
> Hi,
> 
> attached is a version against 2.6.10-bk8.
> 
> Serge Hallyn <serue@us.ibm.com> wrote:
> 
> > The following patch splits bprm_apply_creds into two functions,
> > bprm_apply_creds and bprm_post_apply_creds.  The latter is called
> > after the task_lock has been dropped.  Without this patch, SELinux
> > must drop the task_lock and re-acquire it during apply_creds, making
> > the 'unsafe' flag meaningless to any later security modules.  Please
> > apply.
> 
> thanks,
> -serge
> 
> Signed-off-by: Serge Hallyn <hallyn@cs.wm.edu>

Let me try this again...

Signed-off-by: Chris Wright <chrisw@osdl.org>

sorry for the extra noise,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
