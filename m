Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261337AbSJCVfB>; Thu, 3 Oct 2002 17:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261323AbSJCVfB>; Thu, 3 Oct 2002 17:35:01 -0400
Received: from gw.openss7.com ([142.179.199.224]:3082 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id <S261337AbSJCVeN>;
	Thu, 3 Oct 2002 17:34:13 -0400
Date: Thu, 3 Oct 2002 15:39:43 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: kernel <linux-kernel@vger.kernel.org>
Subject: export of sys_call_table
Message-ID: <20021003153943.E22418@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see that RH, in their infinite wisdom, have seen fit to remove
the export of sys_call_table in 8.0 kernels breaking any loadable
modules that wish to implement non-implemented system calls such
as LiS's or iBCS implementation of putmsg/getmsg.

sys_call_table is exported in current 2.4 and 2.5 kernels.

Until now, loadable modules have been able to just overwrite
the non implemented point in the sys_call_table when they load
and putting it back when they unload.  There is no mechanism
for registering system calls.

What is the kernel.org take on this?

--brian

-- 
Brian F. G. Bidulock    ¦ The reasonable man adapts himself to the ¦
bidulock@openss7.org    ¦ world; the unreasonable one persists in  ¦
http://www.openss7.org/ ¦ trying  to adapt the  world  to himself. ¦
                        ¦ Therefore  all  progress  depends on the ¦
                        ¦ unreasonable man. -- George Bernard Shaw ¦
