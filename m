Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264141AbRFFUtM>; Wed, 6 Jun 2001 16:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264147AbRFFUsw>; Wed, 6 Jun 2001 16:48:52 -0400
Received: from adsl-63-199-104-197.dsl.lsan03.pacbell.net ([63.199.104.197]:37133
	"HELO mail.theoesters.com") by vger.kernel.org with SMTP
	id <S264141AbRFFUst>; Wed, 6 Jun 2001 16:48:49 -0400
From: "Phil Oester" <phil@theoesters.com>
To: <linux-kernel@vger.kernel.org>
Subject: NFS caching issues on 2.4
Date: Wed, 6 Jun 2001 13:48:48 -0700
Message-ID: <LAEOJKHJGOLOPJFMBEFEEEFNDNAA.phil@theoesters.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've stumbled upon a wierd NFS caching issue on 2.4 which does not seem to
exist in 2.2.  Our www docroot is NFS mounted on a NetApp 760.  We have a
cron job which make changes to the index.html every 5 minutes.

Recently, we upgraded all the web servers to 2.4 and noticed that there were
big delays in seeing these 5 minute updates.  Yet, an ls -l in the nfs
directory on each of the servers clearly shows the new timestamp.  However,
a cat of the file shows that it is the old version (sometimes up to 1 hour
old).  I was using NFSv3, so decided to try NFSv2, but got the same results.

I reverted to 2.2.19 on the boxes (which are RedHat 7.1 incidentally), and
these problems went away.

Any ideas why this is happening?

-Phil Oester

