Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVABO1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVABO1i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 09:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVABO1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 09:27:37 -0500
Received: from web53904.mail.yahoo.com ([206.190.36.214]:53398 "HELO
	web53904.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261220AbVABO1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 09:27:36 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=vni6i9nsnbgwxXH1Y3iwVzXyYRC8s03Fqk8R0nM+SuCzcgAny0/HDNwuwLOCZ1cGJAX4pIip65wxx9RwbIraUgMpu9EGlEffrsF+Gzh3Xk5suc0OjQ06vqqEhDBnqYcmXBXedAnZ5nEyxbiNL1KxhQQL90/VmxhTEFMZdZKa1O8=  ;
Message-ID: <20050102142735.58501.qmail@web53904.mail.yahoo.com>
Date: Sun, 2 Jan 2005 06:27:35 -0800 (PST)
From: <gan_xiao_jun@yahoo.com>
Subject: Disable creation of coredump file
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I want to disable the creation of the core dump even
after set "ulimit -c XXXX"

I modify 
include/asm-i386/resource.h
the data structure INIT_RLIMITS
the 4th elements(RLIMIT_CORE)
from 
rlim_cur = 0, rlim_max = RLIMINFINITY
to 
rlim_cur = 0, rlim_max = 0
But core dump still be created.

Thanks in advance.
gan



		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Helps protect you from nasty viruses. 
http://promotions.yahoo.com/new_mail
