Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267980AbTBSCnq>; Tue, 18 Feb 2003 21:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267982AbTBSCnq>; Tue, 18 Feb 2003 21:43:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7432 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267980AbTBSCnq>;
	Tue, 18 Feb 2003 21:43:46 -0500
Date: Wed, 19 Feb 2003 02:53:47 +0000
From: Matthew Wilcox <willy@debian.org>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] convert atm_dev_lock from spinlock to semaphore
Message-ID: <20030219025347.D22992@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


you seem to be under the impression that <linux/sem.h> has something
to do with linux semaphores.  this is not the case; they're sysv semaphores.

apart from this, i think it's a pretty bad idea to just replace the
spinlocks with semaphores.  atm really needs fixing properly.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
