Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317541AbSHZN3O>; Mon, 26 Aug 2002 09:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317628AbSHZN3O>; Mon, 26 Aug 2002 09:29:14 -0400
Received: from Mgw1-in.nctu.edu.tw ([140.113.54.37]:38043 "EHLO
	Mgw1-in.NCTU.edu.tw") by vger.kernel.org with ESMTP
	id <S317541AbSHZN3N>; Mon, 26 Aug 2002 09:29:13 -0400
Date: Mon, 26 Aug 2002 21:30:28 +0800
From: Zheng Jian-Ming <zjm@cis.nctu.edu.tw>
To: linux-kernel@vger.kernel.org
Subject: problems with changing UID/GID 
Message-ID: <20020826133028.GA21965@cissol7.cis.nctu.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

POSIX states that the credentials (uid, gid, capabilities, etc.) are
process-wide. So when one thread within the process changes some part
of the credentials, all threads see the change.

But, the credentials are per-task in Linux, so it's possible to have
two tasks in a process running under different UIDs.

It may have problems when we change UID/GID in one task within the
thread group.

How to deal with it? Will Linux kernel move credentials into a shared
structure?

Thank you.

-- 
Best Regards,
