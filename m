Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269687AbUJAEFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269687AbUJAEFc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 00:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269688AbUJAEFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 00:05:32 -0400
Received: from mail.joq.us ([67.65.12.105]:40671 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S269687AbUJAEFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 00:05:21 -0400
To: Chris Wright <chrisw@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de
Subject: Re: [PATCH] Realtime LSM
References: <1094967978.1306.401.camel@krustophenia.net>
	<20040920202349.GI4273@conscoop.ottawa.on.ca>
	<20040930211408.GE4273@conscoop.ottawa.on.ca>
	<1096581213.24868.19.camel@krustophenia.net>
	<87pt43clzh.fsf@sulphur.joq.us>
	<20040930182053.B1973@build.pdx.osdl.net>
From: "Jack O'Quin" <joq@io.com>
Date: 30 Sep 2004 23:05:14 -0500
In-Reply-To: <20040930182053.B1973@build.pdx.osdl.net>
Message-ID: <87k6ubcccl.fsf@sulphur.joq.us>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> writes:

> This uses the basic rlimits infrastructure.  You can manage it manually
> in a shell with ulimit -l, or you can use pam (pam_limits) to configure
> per uid limits.  There's a pam doc that describes limits, and a manpage
> for ulimit.  It's really easy to use, and should eliminate the need for
> the mlock part of that module.

Thanks for the pointer, Chris.

I'll see if I can figure out a way to make that useable for musicians.

The ulimit approach is way too cumbersome.

The pam_limits solution is not well-documented on my Debian system,
which doesn't even have a man page for /etc/security/limits.conf,
though the file has comments, now that I know where to look.  PAM is
powerful and flexible, but "easy to use" is not a phrase that comes
readily to mind.  :-)

The PAM approach would probably be workable for special-purpose audio
distributions like Planet CCRMA or DeMuDi.  That still leaves all the
audio developers with a significant challenge trying to explain every
configuration step to all our other users.  AFAICT, PAM configuration
is rather distribution-specific, so that could become a significant
burden.

It appears that a limits.conf line like this might work...

@audio - memlock 10000        # is there any way to say "unlimited"?

I'll experiment tomorrow to see if I can actually make this work.
-- 
  joq
