Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311915AbSCOCya>; Thu, 14 Mar 2002 21:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311918AbSCOCyV>; Thu, 14 Mar 2002 21:54:21 -0500
Received: from web10504.mail.yahoo.com ([216.136.130.154]:9740 "HELO
	web10504.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S311916AbSCOCyP>; Thu, 14 Mar 2002 21:54:15 -0500
Message-ID: <20020315025415.79521.qmail@web10504.mail.yahoo.com>
Date: Thu, 14 Mar 2002 18:54:15 -0800 (PST)
From: Andy Tai <lichengtai@yahoo.com>
Reply-To: atai@atai.org
Subject: null pointer error in raw device I/O from kernel threads
To: linux-kernel@vger.kernel.org
Cc: atai@atai.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I am trying to do I/O to raw devices from within
kernel threads.  I got null pointer error because the
raw device code references current->mm, but for kernel
threads, current->mm is 0 (NULL).  I tried to force it
to use current->active_mm but the I/O operation
returns EFAULT (-14).  

Any advice on how to make raw device I/O work from
kernel threads is appreciated.



__________________________________________________
Do You Yahoo!?
Yahoo! Sports - live college hoops coverage
http://sports.yahoo.com/
