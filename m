Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318121AbSHZOyj>; Mon, 26 Aug 2002 10:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318123AbSHZOyj>; Mon, 26 Aug 2002 10:54:39 -0400
Received: from pD9E2394F.dip.t-dialin.net ([217.226.57.79]:7345 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318121AbSHZOyi>; Mon, 26 Aug 2002 10:54:38 -0400
Date: Mon, 26 Aug 2002 08:58:25 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Zheng Jian-Ming <zjm@cis.nctu.edu.tw>
cc: linux-kernel@vger.kernel.org
Subject: Re: problems with changing UID/GID 
In-Reply-To: <20020826133028.GA21965@cissol7.cis.nctu.edu.tw>
Message-ID: <Pine.LNX.4.44.0208260855480.3234-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 26 Aug 2002, Zheng Jian-Ming wrote:
> POSIX states that the credentials (uid, gid, capabilities, etc.) are
> process-wide. So when one thread within the process changes some part
> of the credentials, all threads see the change.
> 
> But, the credentials are per-task in Linux, so it's possible to have
> two tasks in a process running under different UIDs.
> 
> It may have problems when we change UID/GID in one task within the
> thread group.
> 
> How to deal with it? Will Linux kernel move credentials into a shared
> structure?

There was some piece of work on that, done by Dave McCracken. But it 
lately had this "little security hole you could drive a big yellow truck 
with flashlights on through" problem...

I personally like the task->cred->cr_uid, etc. approach. Helps a lot.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

