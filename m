Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262658AbVAEXRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262658AbVAEXRf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 18:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbVAEXRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 18:17:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:62187 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262658AbVAEXQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 18:16:43 -0500
Date: Wed, 5 Jan 2005 15:16:38 -0800
From: Chris Wright <chrisw@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] split bprm_apply_creds into two functions
Message-ID: <20050105151638.C2357@build.pdx.osdl.net>
References: <20050104183043.GA3592@IBM-BWN8ZTBWA01.austin.ibm.com> <20050105151434.B2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050105151434.B2357@build.pdx.osdl.net>; from chrisw@osdl.org on Wed, Jan 05, 2005 at 03:14:34PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Wright (chrisw@osdl.org) wrote:
> * Serge E. Hallyn (serue@us.ibm.com) wrote:
> > The following patch splits bprm_apply_creds into two functions,
> > bprm_apply_creds and bprm_post_apply_creds.  The latter is called
> > after the task_lock has been dropped.  Without this patch, SELinux
> > must drop the task_lock and re-acquire it during apply_creds, making
> > the 'unsafe' flag meaningless to any later security modules.  Please
> > apply.
> > 
> > thanks,
> > -serge
> > 
> > Signed-off-by: Serge Hallyn <serue@us.ibm.com>
> 
> Signed-off-by: Chris Wright <chrisw@osdl.org>

Err, replied to the wrong email.  Meant to reply to the 'resend'

ugh,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
