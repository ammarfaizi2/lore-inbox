Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268674AbUJDXMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268674AbUJDXMe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 19:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268677AbUJDXMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 19:12:34 -0400
Received: from pat.uio.no ([129.240.130.16]:40656 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S268674AbUJDXKT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 19:10:19 -0400
Subject: RE: [NFS] Re: [PATCH] NFS using CacheFS
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Lever, Charles" <cel@netapp.com>
Cc: Steve Dickson <SteveD@redhat.com>, nfs@lists.sourceforge.net,
       Linux filesystem caching discussion list 
	<linux-cachefs@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <482A3FA0050D21419C269D13989C611302B07E52@lavender-fe.eng.netapp.com>
References: <482A3FA0050D21419C269D13989C611302B07E52@lavender-fe.eng.netapp.com>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1096931401.22446.157.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 05 Oct 2004 01:10:02 +0200
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På ty , 05/10/2004 klokka 00:51, skreiv Lever, Charles:

> probably ought to look like the Solaris UI here.  isn't there a "cachefs" mount option on Solaris?  anyway, reusing "posix" just for a prototype seems harmless enough.

Mounting Solaris cachefs is very different. Their syntax is of the form:

mount -F cachefs [    generic_options     ] -o backfstype=file_system_type   [  specific_options  ]  [ -O ] special mount_point

So an example given on their manpage is as follows:

------
     The  following  example  CacheFS-mounts  the   file   system
     server1:/user2,  which is already NFS-mounted on /usr/abc as
     /xyz.

      example# mount -F cachefs -o backfstype=nfs,backpath=/usr/abc,
          cachedir=/cache1 server1:/user2 /xyz
------

Cheers,
  Trond

