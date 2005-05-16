Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVEPQgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVEPQgK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 12:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVEPQgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 12:36:09 -0400
Received: from web60414.mail.yahoo.com ([209.73.178.157]:34170 "HELO
	web60414.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261736AbVEPQgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 12:36:05 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=IJNvJ1TZ8dxeSX4LiSMup4KYCIyIH/rJQ9Nh1/O16xqz2eIVsc6x1LGAeeeKfWFNohhUwTyKhm9Vge+dA+WXXuy0vRZ5/3KbQ0Pyix+7T+x2Y19F5PSEyhj8OhxoFV6DsEMTN0R0GEGGM61b2uGzHsdLH66NcPOXImEmZ+hBBTQ=  ;
Message-ID: <20050516163601.59819.qmail@web60414.mail.yahoo.com>
Date: Mon, 16 May 2005 09:36:00 -0700 (PDT)
From: Mike Smith <mks_2981@yahoo.com>
Subject: Accessing non-current process' logical address space
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm in the process of modifying the 2.4.28 Linux
Kernel.  As part of my research I’m implementing a
special system call where I need to be able to read
and write to another processes’ logical-address space.

Given a process (struct task_struct* P) a logical
address space pointer (char* logical_address_ptr) and
a value (char x) is there a way to put x into P's
logical address space where logical_address_ptr points
to?  I have it organized so that process P is
expecting the value at logical_address_ptr to be
modified and P is on a wait queue until it gets
modified.

I know about all the *_user macros in
include/asm-i386/uaccess.h.  All of these macros act
on the current process logical address space.  Are
there any similar functions that act on any arbitrary
process’ logical address space?  If not, are there any
thoughts on how I should go about implementing them?

Thanks in advance,
Mike



		
Yahoo! Mail
Stay connected, organized, and protected. Take the tour:
http://tour.mail.yahoo.com/mailtour.html

