Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262095AbVCNKFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbVCNKFo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 05:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVCNKFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 05:05:44 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:30901 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S262095AbVCNKFe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 05:05:34 -0500
Date: Mon, 14 Mar 2005 11:07:22 +0100
From: DervishD <lkml@dervishd.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.29 'make dep' error
Message-ID: <20050314100722.GA6684@DervishD>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :)

    I don't know if I've had this error previously, I noticed it this
morning when recompiling the kernel *I already use*. When doing 'make
dep' I had this:

    make[1]: Leaving directory `/usr/kernel'
    scripts/mkdep -- `find /usr/kernel/include/asm /usr/kernel/include/linux
      /usr/kernel/include/scsi /usr/kernel/include/net /usr/kernel/include/math-emu
      \( -name SCCS -o -name .svn \) -prune -o -follow -name \*.h !
      -name modversions.h -print` > .hdepend
    find: /usr/kernel/include/asm: Too many levels of symbolic links
    scripts/mkdep -- init/*.c > .depend

    I've break the long line invoking the 'scripts/mkdep' binary so
it's easier to read. I don't know why the heck 'find' fails with
ELOOP :?? Just a simple 'find /usr/kernel/include/asm -follow' causes
'find' to issue a open call that fails with ELOOP. I'm using version
4.2.18 (I updated recently my findutils) and version 4.2.15 doesn't
show the problem.

    I just wanted to warn everybody on the list about this problem.
I'm going to write to findutils people to report the bug.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
It's my PC and I'll cry if I want to...
