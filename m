Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267973AbTBSEm6>; Tue, 18 Feb 2003 23:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268883AbTBSEm6>; Tue, 18 Feb 2003 23:42:58 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:60039 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S267973AbTBSEm5>; Tue, 18 Feb 2003 23:42:57 -0500
Message-Id: <200302190452.h1J4qoGi002198@locutus.cmf.nrl.navy.mil>
To: Matthew Wilcox <willy@debian.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] convert atm_dev_lock from spinlock to semaphore 
In-reply-to: Your message of "Wed, 19 Feb 2003 02:53:47 GMT."
             <20030219025347.D22992@parcelfarce.linux.theplanet.co.uk> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Tue, 18 Feb 2003 23:52:50 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030219025347.D22992@parcelfarce.linux.theplanet.co.uk>,Matthew Wilcox writes:
>you seem to be under the impression that <linux/sem.h> has something
>to do with linux semaphores.  this is not the case; they're sysv semaphores.

sorry about that.  i just picked what seemed like likely culprits for
header files.

>apart from this, i think it's a pretty bad idea to just replace the
>spinlocks with semaphores.  atm really needs fixing properly.

yes, atm_dev_lock is wrapped around large chunks of the code. however,
it should probably never have been a spinlock--it certainly doesnt need
to be one.  as a mutex its far less offensive.  i am willing to take
suggestions as to what would need to be done to fix atm properly?
