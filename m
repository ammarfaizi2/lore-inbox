Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263820AbRFDS2v>; Mon, 4 Jun 2001 14:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263818AbRFDS2g>; Mon, 4 Jun 2001 14:28:36 -0400
Received: from phnx1-blk2-hfc-0251-d1db10f1.rdc1.az.coxatwork.com ([209.219.16.241]:46007
	"EHLO mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S263815AbRFDS2P>; Mon, 4 Jun 2001 14:28:15 -0400
Message-ID: <00de01c0ed24$b9642ed0$6daaa8c0@Kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.5(-ac*] still broken NFS/Reiserfs
Date: Mon, 4 Jun 2001 11:32:35 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got two machines here running 2.4.5-ac6 with Chris Mason's posted 2.4.5
Reiserfs/knfsd patch, plus the small 2.4.5 NFS client patch posted last week
as well. Even with all of this, I still have NFS weirdness.

>From the client, I can mount and read pretty much anything I like from the
server. I can create files in existing directories on the server. I can
create new directories on the server. I _cannot_, however, create anything
in a directory I created from the client (I get "file/directory does not
exist" errors). I have also seen one case where the client's directory
listing for a directory at the root of an export point did not match the
server's listing until I unmounted and remounted the NFS  mount.

Most of the time, this problem does not occur. It's very intermittent. I can
boot up my client, and it will work fine for 24 hours, or it will fail in
five minutes. Once it fails, an unmount/remount seems to cure it.

There is still major weirdness going on here, and I'm hesitant to try unfsd
unless someone can say that it works reliably... I do need to find a
solution to this though, and am willing to help in whatever way I can.


