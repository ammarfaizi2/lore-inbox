Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262383AbVADW5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbVADW5b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 17:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbVADWzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 17:55:23 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:63467 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262385AbVADWXH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 17:23:07 -0500
Subject: Re: [RFC] [PATCH] merge *_vm_enough_memory()s into a common helper
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris Wright <chrisw@osdl.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050104141712.E469@build.pdx.osdl.net>
References: <20050104214833.GA3420@IBM-BWN8ZTBWA01.austin.ibm.com>
	 <20050104141712.E469@build.pdx.osdl.net>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1104877039.20724.175.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 04 Jan 2005 17:17:19 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-04 at 17:17, Chris Wright wrote:
> * Serge E. Hallyn (serue@us.ibm.com) wrote:
> 
> I'm fine with this with a few nits.  Although I don't think it will apply
> to current bk which has merge error in this area right now.  Stephen,
> are you ok with the way this one generates audit messages?

Looks like the patch (with suggested fixes) will preserve the current
behavior, i.e. no audit message generation for SELinux from the
vm_enough_memory hook, while still auditing real uses of CAP_SYS_ADMIN
elsewhere.  That is what we want.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

