Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbSJMIKt>; Sun, 13 Oct 2002 04:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261457AbSJMIKt>; Sun, 13 Oct 2002 04:10:49 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:53635 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id <S261456AbSJMIKt>; Sun, 13 Oct 2002 04:10:49 -0400
From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
To: "'David S. Miller'" <davem@redhat.com>
Cc: <robm@fastmail.fm>, <hahn@physics.mcmaster.ca>,
       <linux-kernel@vger.kernel.org>, <jhoward@fastmail.fm>
Subject: RE: Strange load spikes on 2.4.19 kernel
Date: Sun, 13 Oct 2002 03:16:30 -0500
Message-ID: <000e01c27290$dd0b5640$7443f4d1@joe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <20021013.005005.41948345.davem@redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> But there is no fundamental reason for that, we just haven't
>>> gotten around to threading that bit yet.
   
>> Oh yes there is.  What if an allocation of blocks and/or
>> inodes is preempted?  Another thread could attempt to
>> allocate the same set of blocks and/or inodes.
   
> That's why we protect the allocation with SMP locking
> primitives which under Linux prevent preemption.

"SMP locking primitives"? Tell me what that is again?  Oh yeah!  That's
when the kernel basically gives SMP a timeout and behaves as if there
was only one processor.

So in effect, I was right.  File processes really do use one and only
one processor.

> This isn't rocket science....

I agree.  I totally agree.

