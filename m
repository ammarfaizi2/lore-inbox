Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbVADVve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbVADVve (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 16:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVADVsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:48:36 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:6376 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262276AbVADVrN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:47:13 -0500
Subject: Re: [PATCH] split bprm_apply_creds into two functions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       James Morris <jmorris@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050104183043.GA3592@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <20050104183043.GA3592@IBM-BWN8ZTBWA01.austin.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1104874872.20724.155.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 04 Jan 2005 16:41:12 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-04 at 13:30, Serge E. Hallyn wrote:
> The following patch splits bprm_apply_creds into two functions,
> bprm_apply_creds and bprm_post_apply_creds.  The latter is called
> after the task_lock has been dropped.  Without this patch, SELinux
> must drop the task_lock and re-acquire it during apply_creds, making
> the 'unsafe' flag meaningless to any later security modules.  Please
> apply.
> 
> thanks,
> -serge
> 
> Signed-off-by: Serge Hallyn <serue@us.ibm.com>

Signed-off-by:  Stephen Smalley <sds@epoch.ncsc.mil>

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

