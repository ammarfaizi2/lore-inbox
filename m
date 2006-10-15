Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752333AbWJODAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbWJODAH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 23:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbWJODAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 23:00:06 -0400
Received: from main.gmane.org ([80.91.229.2]:63142 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751136AbWJODAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 23:00:05 -0400
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
From: Steve Youngs <steve@youngs.au.com>
Subject: Bad core files with 2.6.19-rc2
Date: Sun, 15 Oct 2006 12:53:41 +1000
Organization: Linux Users - Fanatics Dept.
Message-ID: <microsoft-free.87mz7yjnm2.fsf@youngs.au.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
Keywords: gdb,core
X-Gmane-NNTP-Posting-Host: 203-206-170-37.perm.iinet.net.au
X-Face: #/1'_-|5_1$xjR,mVKhpfMJcRh8"k}_a{EkIO:Ox<]@zl/Yr|H,qH#3jJi6Aw(Mg@"!+Z"C
 N_S3!3jzW^FnPeumv4l#,E}J.+e%0q(U>#b-#`~>l^A!_j5AEgpU)>t+VYZ$:El7hLa1:%%L=3%B>n
 K{^jU_{&
Mail-Copies-To: never
X-X-Day: Only 2430588 days till X-Day.  Got Slack?
X-URL: <http://www.youngs.au.com/~steve/>
X-Request-PGP: <http://www.youngs.au.com/~steve/pgp/sryoungs.asc>
X-OpenPGP-Fingerprint: 1659 2093 19D5 C06E D320  3A20 1D27 DB4B A94B 3003
X-Now-Playing: We Can Get Together --- [Flowers]
X-Discordian-Date: Pungenday, the 69th day of Bureaucracy, 3172. 
X-Attribution: SY
User-Agent: Gnus/5.110006 (No Gnus v0.6) SXEmacs/22.1.6 (Cadillac, linux)
Cancel-Lock: sha1:ZKB13hIkgBsFQK82UcIO4eDdhoA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gdb doesn't like any core dump file generated while running
2.6.19-rc2.  If I `kill -SIGSEGV $some_app_pid' and then...

  gdb some_app core

I get...

  warning: Couldn't find general-purpose registers in core file.
  #0  0x00000000 in ?? ()

But if I gdb attach to a running process and then kill -SIGSEGV
the process, it produces a normal trace without problem.


-- 
|---<Steve Youngs>---------------<GnuPG KeyID: A94B3003>---|
|                   Te audire no possum.                   |
|             Musa sapientum fixa est in aure.             |
|----------------------------------<steve@youngs.au.com>---|

