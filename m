Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266832AbUG1H5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266832AbUG1H5S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 03:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266827AbUG1H4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 03:56:41 -0400
Received: from mx2.elte.hu ([157.181.151.9]:26547 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266838AbUG1HjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 03:39:12 -0400
Date: Wed, 28 Jul 2004 09:37:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch][selinux] Fix clearing of new personality bit on security transitions
Message-ID: <20040728073741.GA17537@elte.hu>
References: <1090945303.2448.161.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090945303.2448.161.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Stephen Smalley <sds@epoch.ncsc.mil> wrote:

> This patch against 2.6.8-rc2-bk6 moves the clearing of the new
> personality bit from selinux_bprm_apply_creds (called from
> compute_creds) to selinux_bprm_set_security (called from
> prepare_binprm).  This ensures that the bit is cleared at the same point
> in exec processing as for setuid/setgid binaries, prior to setting up
> the new image.  Please apply.
> 
> Signed-off-by:  Stephen Smalley <sds@epoch.ncsc.mil>

yeah, thanks for the fix.

 Signed-off-by: Ingo Molnar <mingo@elte.hu>

	Ingo
