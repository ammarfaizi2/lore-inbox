Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265540AbUGDTSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265540AbUGDTSM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 15:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265649AbUGDTSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 15:18:12 -0400
Received: from outmx009.isp.belgacom.be ([195.238.3.4]:34216 "EHLO
	outmx009.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S265540AbUGDTSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 15:18:09 -0400
Subject: [OFFTOPIC] f_pos ?
From: FabF <fabian.frederick@skynet.be>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1088968685.2429.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 04 Jul 2004 21:18:05 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	
	I try to understand how readdir process works and I can't understand
f_pos management :

        Having in mind things work that way :

        user : ls
        glibc : 
                open (->sys_open)
                getdentries64 (->sys_getdentries64)
                
        kernel:
                sys_getdentries64
                ->vfs_readdir
                        ->ext2_readdir

At that point, I don't understand why ext2_readdir is playing with
filp->f_pos .... It should be 0 ...Why does it care about offset ?

Thanks in advance for your precious help,
FabF

