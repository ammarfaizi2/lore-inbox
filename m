Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVCQPoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVCQPoJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 10:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVCQPoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 10:44:09 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:60803 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261613AbVCQPoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 10:44:05 -0500
To: Stelian Pop <stelian.pop@fr.alcove.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: BKCVS broken ?
References: <20050317144522.GK22936@hottah.alcove-fr>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Thu, 17 Mar 2005 15:43:54 +0000
In-Reply-To: <20050317144522.GK22936@hottah.alcove-fr> (Stelian Pop's
 message of "Thu, 17 Mar 2005 15:45:22 +0100")
Message-ID: <tnxd5tymg5h.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop <stelian.pop@fr.alcove.com> wrote:
> The current bkcvs export is broken, several recent changesets are
> missing from it.
>
> This occurs at least in the mm/ directory, but I haven't verified
> if other directories are not affected. I detected this problem
> because the head of bkcvs doesn't compile anymore and shows errors
> in mm/* missing symbols.

I noticed a similar problem a few days ago. The ChangeSet,v file
contained the logs but there were no files with the corresponding
(Logical change ...). A day later, the files corresponding to those
logs were updated. I initially blamed the non-atomicity of CVS and
rsync but, reading your e-mail, the problem might not be that simple.

BTW, is there a way for the ChangeSet,v file to be updated after all
the source files are updated (to avoid the empty patch problem if
rsync'ing when the BKCVS repository is updated)?

Catalin

