Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270726AbTHAK6s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 06:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275237AbTHAK4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 06:56:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41739 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S275236AbTHAKzw (ORCPT
	<rfc822;linux-kernel@vger.redhat.com>);
	Fri, 1 Aug 2003 06:55:52 -0400
Date: 1 Aug 2003 10:57:06 -0000
Message-ID: <20030801105706.30523.qmail@webmail28.rediffmail.com>
MIME-Version: 1.0
From: "Dinesh  Gandhewar" <dinesh_gandhewar@rediffmail.com>
Reply-To: "Dinesh  Gandhewar" <dinesh_gandhewar@rediffmail.com>
To: mlist-linux-kernel@nntp-server.caltech.edu
Subject: volatile variable
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

If a system call is having following code.

add current process into wait quque ;
while (1)
{  set task state INTERRUPTIBLE ;
    if (a > 0)
      break ;
    schedule() ;
}
set task state RUNNING ;
remove current from wait queue ;


If an interrupt service is having following code

set a = 512 ;

'a' is a global variable shared in ISR and system call

Do I need to define a as 'volatile int a ;' ? Why?

Thanks & Regards,
Dinesh




___________________________________________________
Download the hottest & happening ringtones here!
OR SMS: Top tone to 7333
Click here now: 
http://sms.rediff.com/cgi-bin/ringtone/ringhome.pl


