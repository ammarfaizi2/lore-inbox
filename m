Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261612AbSI0DQr>; Thu, 26 Sep 2002 23:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261613AbSI0DQr>; Thu, 26 Sep 2002 23:16:47 -0400
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:55311 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S261612AbSI0DQr>;
	Thu, 26 Sep 2002 23:16:47 -0400
Subject: bug in sys_getpid() comment?
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1033096884.5495.8.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 26 Sep 2002 23:21:25 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is sys_getpid() on 2.4.19

asmlinkage long sys_getpid(void)
{
        /* This is SMP safe - current->pid doesn't change */
        return current->tgid;
}

I assume we are returning tgid so that no matter what thread of a
multithreaded program calls getpid we return the same value, and that
the comment with pid is old and should have been updated when it was
changed to return tgid.  A student in my Operating Systems class pointed
this out, so I figured no harm in pointing the possible bug out.

thanks,

shaya

