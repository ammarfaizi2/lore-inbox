Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265440AbTHJNZA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 09:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265922AbTHJNZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 09:25:00 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:57713 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S265440AbTHJNY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 09:24:59 -0400
Message-ID: <D9B4591FDBACD411B01E00508BB33C1B014053AC@mesadm.epl.prov-liege.be>
From: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
To: "'mochel@osdl.org'" <mochel@osdl.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [PATCH] shm to sysfs rebuild.
Date: Sun, 10 Aug 2003 15:24:56 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick,

	Here's shm to sysfs rebuild following your advices :

	Summary :

		-Removing kobj_map 
		-Adding object memsetting rather than field/field NULL 
		-Declaring attributes global 
		-Adding pointer compare rather than string compare 
		-Removing unnecessary pressure on the stack 
		-Using kobj_type 
		-shm destruction moved to kobject release function 
		-id seek was trivial.Attrshow rewritten. 
		-Tested against recursive fgreps-kde-personal benchmark
program 
		-Removed might_sleep warning (shm_unlock was global lock to
kobject_registration (fs 		node lock) 
		-Checking release code in front of all shm_destroy calls. 

Patch: http://fabian.unixtech.be/kernel/shmkobject090803.diff

	It's against 2.6.0test2.If it's ok to you, could you apply ?

Regards,
Fabian
