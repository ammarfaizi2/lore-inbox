Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272481AbTHEHrc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 03:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272563AbTHEHrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 03:47:32 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:63872 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S272481AbTHEHrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 03:47:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Amon Ott <ao@rsbac.org>
Organization: RSBAC
To: RSBAC List <rsbac@rsbac.org>
Subject: Announce: RSBAC v1.2.2 released
Date: Tue, 5 Aug 2003 09:49:25 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Suse-Security <suse-security@suse.com>,
       sec@linux-sec.net
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <19jwX7-28IRrE0@fmrl00.sul.t-online.com>
X-Seen: false
X-ID: ZZR9uuZBZe0mDFFbUcyQtddzOQJ7Ki9zIUOGd0S8SRpyRaXN9qaCEk@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Rule Set Based Access Control (RSBAC) version 1.2.2 has been released.
Full information and downloads are available from http://www.rsbac.org

RSBAC is a flexible, powerful and fast open source access control framework
for current Linux kernels, which has been in stable production use since
January 2000 (version 1.0.9a). All development is independent of governments
and big companies, and no existing access control code has been reused.

The system includes a big range of decision modules, some of which implement 
professional access control models like ACL, MAC or Role Compatibility. It 
supports both 2.4 and 2.2 kernel series. Now that 2.6 seems to stabilize, the 
port to 2.6.0-test is in progress.

New features compared to version 1.2.1:

- Malware scanning:
       - Added ms_need_scan attribute for selective scanning
       - MS module support for F-Protd as scanning engine
       - ms_need_scan FD attribute for selective scanning
       - MS module support for clamd as scanning engine.
- Jails:
       - JAIL flag allow_inet_localhost to additionally allow to/from
         local/remote IP 127.0.0.1
- Resource Control:
       - New RES module with minimum and maximum resource settings for
         users and programs
- Authentication Enforcement:
       - Moved AUTH module to generic lists with ttl
       - Added caps and checks for effective and fs owner to AUTH module
         (optional)
- Linux Capabilities:
       - New Process Hiding feature in CAP module
- MAC / Bell-LaPadula:
       - Almost complete reimplementation of the MAC model with many new
         features.
- General:
       - RSBAC syscall version numbers
       - Added new requests CHANGE_DAC_(EFF|FS)_OWNER on PROCESS targets
         for seteuid and setfsuid (configurable)
       - Changed behaviour on setuid etc.: Notification is always sent, even
         if the uid was set to the same value. This allows for restricted RC
         initial roles with correct role after setuid to root.
       - Delayed init for initial ramdisks: delay RSBAC init until the first
         real or a specific device mount.
       - rsbac_init() syscall to trigger init by hand, if not yet
         initialized - can be used with e.g. rsbac_delayed_root=99:99, which
         will never trigger init automatically.
       - New system role 'auditor' for most models, which may read and flush
         RSBAC own log.

Amon Ott.
-- 
http://www.rsbac.org - GnuPG: 2048g/5DEAAA30 2002-10-22
