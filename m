Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269637AbUJAAg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269637AbUJAAg6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 20:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269639AbUJAAg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 20:36:58 -0400
Received: from mail.joq.us ([67.65.12.105]:1503 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S269637AbUJAAg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 20:36:56 -0400
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de
Subject: Re: [PATCH] Realtime LSM
References: <1094967978.1306.401.camel@krustophenia.net>
	<20040920202349.GI4273@conscoop.ottawa.on.ca>
	<20040930211408.GE4273@conscoop.ottawa.on.ca>
	<1096581213.24868.19.camel@krustophenia.net>
From: "Jack O'Quin" <joq@io.com>
Date: 30 Sep 2004 19:37:06 -0500
In-Reply-To: <1096581213.24868.19.camel@krustophenia.net>
Message-ID: <87pt43clzh.fsf@sulphur.joq.us>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> writes:

> Another issue that was raised was that the mlock stuff is also
> unnecessary, because rlimits can do this now.  Is this the case?

I don't know.  The idea was not explained in enough detail for me to
understand if it would be simple enough to administer.  Where can I
find out more?

Does this somehow explain the need for CAP_SYS_RESOURCE when calling
mlockall()?  Comments in capability.h seem to imply that only
CAP_IPC_LOCK is required, which is not true.  I never found any
explicit CAP_SYS_RESOURCE test in mm/mlock.c, though it does check
`rlim[RLIMIT_MEMLOCK].rlim_cur'.
-- 
  joq
