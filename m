Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313041AbSDOTZl>; Mon, 15 Apr 2002 15:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313172AbSDOTZk>; Mon, 15 Apr 2002 15:25:40 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26129 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313041AbSDOTZj>; Mon, 15 Apr 2002 15:25:39 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: link() security
Date: 15 Apr 2002 12:25:27 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a9f9f7$cng$1@cesium.transmeta.com>
In-Reply-To: <20020411192122.F5777@pizzashack.org> <s5gpu11rpgx.fsf@egghead.curl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <s5gpu11rpgx.fsf@egghead.curl.com>
By author:    "Patrick J. LoPresti" <patl@curl.com>
In newsgroup: linux.dev.kernel
> Actually, that is a horrible policy from a security perspective.  The
> shared mail spool itself is a poor design and always has been.
> 
> A better design is to use a separate spool directory for each user
> (/var/spool/mail/user/ or ~user/mail/ or somesuch), and only allow
> that user to access it at all.  This solves *all* of the security
> problems you mention:
> 
>    *) It avoids attacks based on race conditions, because you cannot
>       create files in somebody else's spool.
> 
>    *) Admins can manage space with quotas or partitions just like they
>       do for user home directories (i.e., it is a solved problem).
> 
>    *) You cannot link() to somebody else's spool file because you
>       cannot even read the directory in which it resides.
> 
> The solution to a fundamentally broken spool design is to fix that
> design, not to patch the kernel in nonstandard ways to plug just one
> of its multiple flaws.

Not to mention the fact that the single file mailbox design is itself
flawed.  Mailboxes are fundamentally directories, which news server
authors quickly realized.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
