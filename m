Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318762AbSH1INR>; Wed, 28 Aug 2002 04:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318765AbSH1INR>; Wed, 28 Aug 2002 04:13:17 -0400
Received: from c65.h202052108.is.net.tw ([202.52.108.65]:9877 "EHLO
	webmail.iei.com.tw") by vger.kernel.org with ESMTP
	id <S318762AbSH1INR>; Wed, 28 Aug 2002 04:13:17 -0400
Message-ID: <00cf01c24e6b$678127e0$1d0d11ac@ieileb9wqxg5qq>
From: "Kevin Liao" <kevinliao@iei.com.tw>
To: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0208271239580.2564-100000@penguin.transmeta.com> <20020828081412.GA1496@spunk>
Subject: Writing files to remote storage
Date: Wed, 28 Aug 2002 16:17:50 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
X-MIMETrack: Itemize by SMTP Server on webmail/iei2(Release 5.0.8 |June 18, 2001) at
 2002/08/28 04:18:12 PM,
	Serialize by Router on webmail/iei2(Release 5.0.8 |June 18, 2001) at 2002/08/28
 04:18:19 PM,
	Serialize complete at 2002/08/28 04:18:19 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I don't know whether it's proper to post such a problem in this mailing
list,
but I guess someone here could help me...

If I mount a remote linux partition through smb or nfs and write one file to
that partition. How could I make sure that that file is really written to
the remote disk successfully? I know that some cache mechanisms existed in
linux kernel. So I guess there may be two possibilities as below:

1. After the call write() returns successfully, the file has been actually
in the local cache and then submit to remote cache later.
2. After the call write() returns successfully, the file has been actually
in the remote cache and then submit to remote disk later.

Then, no matter which one of the above two situations happens, the data is
not yet written to the physical storage at that time, right? Should I need
to call fsync() each time after calling write()? Thanks a lot!

Regards,
Kevin


