Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbULHTHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbULHTHL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 14:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbULHTHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 14:07:11 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:60841 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261318AbULHTHE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 14:07:04 -0500
Subject: Re: [2.6 patch] selinux: possible cleanups
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Adrian Bunk <bunk@stusta.de>
Cc: James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       selinux@tycho.nsa.gov
In-Reply-To: <1102089296.29971.110.camel@moss-spartans.epoch.ncsc.mil>
References: <20041128190139.GD4390@stusta.de>
	 <1102089296.29971.110.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1102532326.26951.129.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 08 Dec 2004 13:58:46 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-03 at 10:54, Stephen Smalley wrote:
> - Shouldn't the AVC_CALLBACK_* definitions other than RESET be removed
> since you are removing the other avc_ss interfaces?

Actually, we'd have to keep at least the GRANT definition as well, since
that is used from avc_has_perm_noaudit() for the permissive mode case,
and I suppose we might as well leave the others alone and not disturb
the avc_update_node() code.  So the only changes I'd suggest are
removing the security_member_sid diffs (as it is now used) and including
your follow-up diff for making avtab_insert static.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

