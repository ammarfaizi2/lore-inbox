Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261363AbSJHW5K>; Tue, 8 Oct 2002 18:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261344AbSJHWzB>; Tue, 8 Oct 2002 18:55:01 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:14315 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261329AbSJHWyj>; Tue, 8 Oct 2002 18:54:39 -0400
Importance: Normal
Sensitivity: 
Subject: Waking up kernel thread blocked in sock_recvmsg
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF622E0CD7.34DDBCD6-ON87256C4C.007D935A@boulder.ibm.com>
From: "Steven French" <sfrench@us.ibm.com>
Date: Tue, 8 Oct 2002 18:00:17 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 10/08/2002 05:00:19 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the recommended, safe way to wake up a kernel thread blocked in
sock_recvmsg (other than sending data to it or pulling the network cable
out of the wall and generating network errors).   I have tried various
approaches in kernel sock_close, sock_release even wake_up_process.    When
I want to free my captive kernel threads this thread is typically blocked
in tcp_recv_data (on a blocking read of a tcp v4 socket).  I am not certain
that it is not waking up and promptly going back to sleep but it is
certainly not returning to the caller until it really gets data.

Steve French
Samba Team
Senior Software Engineer
Linux Technology Center - IBM Austin
phone: 512-838-2294
email: sfrench@us.ibm.com


