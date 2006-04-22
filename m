Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWDVTQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWDVTQS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWDVTQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:16:17 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55564 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750971AbWDVTQL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:16:11 -0400
Date: Sat, 22 Apr 2006 12:27:33 +0000
From: Pavel Machek <pavel@suse.cz>
To: Tony Jones <tonyj@suse.de>
Cc: linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Message-ID: <20060422122732.GA2354@ucw.cz>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I must say that I do not like this code. I created something similar,
ptrace-based, long time ago. It was called subterfugue.sf.net, and it
was easy-to-use; but it was also very un-unixy, slow, and gross hack.

Unfortunately AA only fixes the 'slow' part by moving it to the
kernel.

> AppArmor mediates access to the file system using absolute path names
> with shell-syntax wildcards, so that "/srv/htdocs/** r" grants read
> access to all files in /srv/htdocs. AppArmor mediates access to POSIX.1e

shell-syntax-parser in kernel is not cool.

> AppArmor is strictly monotonic to security: it only restricts privilege,
> never enhancing privilege. So if you add AppArmor to a system, it only
> becomes more secure or stays the same, the security policy will not add

Not true, as sendmail hole showed long time ago. Error paths tend to
be untested, and AA is very capable of unmasking such bugs.

> AppArmor is *not* intended to protect every aspect of the system from
> every other aspect of the system: the intended usage is that only a
> small fraction of all programs on a Linux system will have AppArmor
> profiles. Rather, AppArmor is intended to protect the system against a
> particular threat.

If it is not scalable to whole system, why bother?

If it is only used for small part of system, why not use subterfugue?
Recently patches were proposed to improve ptrace performance a lot...

> Who Needs This?
> -------------------
> AppArmor is a core part of SUSE Linux.

It is part of suse linux, but I'd not call it core part.

							Pavel
-- 
Thanks, Sharp!
