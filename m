Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262159AbVADV71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbVADV71 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 16:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbVADVzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:55:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:56801 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262378AbVADVwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:52:14 -0500
Date: Tue, 4 Jan 2005 13:52:10 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] split bprm_apply_creds into two functions
Message-ID: <20050104135210.X2357@build.pdx.osdl.net>
References: <20050104183043.GA3592@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050104183043.GA3592@IBM-BWN8ZTBWA01.austin.ibm.com>; from serue@us.ibm.com on Tue, Jan 04, 2005 at 12:30:43PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Serge E. Hallyn (serue@us.ibm.com) wrote:
> The following patch splits bprm_apply_creds into two functions,
> bprm_apply_creds and bprm_post_apply_creds.  The latter is called
> after the task_lock has been dropped.  Without this patch, SELinux
> must drop the task_lock and re-acquire it during apply_creds, making
> the 'unsafe' flag meaningless to any later security modules.  Please
> apply.
> 
> Signed-off-by: Serge Hallyn <serue@us.ibm.com>

Signed-off-by: Chris Wright <chrisw@osdl.org>

