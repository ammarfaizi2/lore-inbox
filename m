Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbULPSW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbULPSW3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 13:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbULPSW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 13:22:29 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:10969 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261972AbULPSVx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 13:21:53 -0500
Subject: Re: [PATCH] Split bprm_apply_creds into two functions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20041216181613.GB3260@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <20041215200005.GB3080@IBM-BWN8ZTBWA01.austin.ibm.com>
	 <20041215145222.V469@build.pdx.osdl.net>
	 <20041216181613.GB3260@IBM-BWN8ZTBWA01.austin.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1103220990.1463.116.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Dec 2004 13:16:30 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-16 at 13:16, Serge E. Hallyn wrote:
> As Stephen points out, it was more a concern about lock nesting.  The
> attached patch simply removes the task_unlock from selinux_bprm_apply_creds,
> and runs just fine on my machine.  Stephen, do you have a preference
> either way, or was the task_unlock to relieve the concerns of others?

I prefer your original patch (with the two minor changes I suggested),
to avoid unnecessary lock nesting.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

