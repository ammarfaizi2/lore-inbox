Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129623AbRBXVpp>; Sat, 24 Feb 2001 16:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129627AbRBXVpg>; Sat, 24 Feb 2001 16:45:36 -0500
Received: from mail.valinux.com ([198.186.202.175]:61188 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129623AbRBXVpY>;
	Sat, 24 Feb 2001 16:45:24 -0500
Date: Sat, 24 Feb 2001 13:45:23 -0800
To: linux-kernel@vger.kernel.org
Subject: Core dumps for threads
Message-ID: <20010224134523.O26109@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Don Dugger <n0ano@valinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can anyone explain why this test is in routine `do_coredump'
in file `fs/exec.c' in the 2.4.0 kernel?

    if (!current->dumpable || atomic_read(&current->mm->mm_users) != 1)
	goto fail;

The only thing the test on `mm_users' seems to be doing is stopping
a thread process from dumping core.  What's the rationale for this?

-- 
Don Dugger
"Censeo Toto nos in Kansa esse decisse." - D. Gale
n0ano@valinux.com
Ph: 303/938-9838
