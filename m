Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287472AbSAHARt>; Mon, 7 Jan 2002 19:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287467AbSAHARj>; Mon, 7 Jan 2002 19:17:39 -0500
Received: from unknown-1-11.windriver.com ([147.11.1.11]:28837 "EHLO
	mail.wrs.com") by vger.kernel.org with ESMTP id <S287464AbSAHARW>;
	Mon, 7 Jan 2002 19:17:22 -0500
From: mike stump <mrs@windriver.com>
Date: Mon, 7 Jan 2002 16:16:32 -0800 (PST)
Message-Id: <200201080016.QAA12225@kankakee.wrs.com>
To: Dautrevaux@microprocess.com, jtv@xs4all.nl
Subject: Re: [PATCH] C undefined behavior fix
Cc: dewar@gnat.com, gcc@gcc.gnu.org, linux-kernel@vger.kernel.org,
        paulus@samba.org, trini@kernel.crashing.org, velco@fadata.bg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Mon, 7 Jan 2002 22:49:07 +0100
> From: jtv <jtv@xs4all.nl>
> To: Bernard Dautrevaux <Dautrevaux@microprocess.com>

> One problem I ran into considering 'char *volatile' was this one:
> the compiler is supposed to disable certain optimizations involving
> registerization and such, but isn't it still allowed to do constant
> folding?

No.  That would be a bug.  gcc used to have volatile bugs, most of
them are now gone.  Please submit a bug report, if you can discover it
again.

I assume you meant something like this:

char * volatile cp;

main() {
  return cp - cp;
}
