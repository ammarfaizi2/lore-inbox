Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbUCETow (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 14:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbUCETow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 14:44:52 -0500
Received: from www.gawab.com ([204.97.230.36]:20239 "HELO gawab.com")
	by vger.kernel.org with SMTP id S262686AbUCETou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 14:44:50 -0500
From: "Ramy M. Hassan" <ramy@gawab.com>
To: <linux-kernel@vger.kernel.org>
Subject: Advanced storage management ( suggestion )
Date: Fri, 5 Mar 2004 21:44:20 +0200
Message-ID: <003801c402ea$44437190$ba10a8c0@ramy>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see many people interested in designing of new filesystems for
different purposes, and one of the common tasks all filesystem designers
will do is to manage device blocks. 
I just thought of starting a new project that aims to create an
advanced, scalable and high performance block level storage management
layer for the Linux kernel. 
This layer should provide low level storage services to simplify the
development of filesystems, DBMS, LDAP servers, or any other
applications that require high performance storage.
The planned features are :
1- Very fast block allocation ( Using balanced trees for tracking free
blocks comes into my mind now, but I still it is early to decide the
design ).
2- Support for multi-disk/multi-host storage pool.
3- Meta data storage and block storage can be isolated for better
performance.
4- Meta data and block replication options.
5- Transactional options for journaling filesystems or transactional
databases.
6- Supports clustering through lock managers where multiple hosts can
read/write to same storage devices concurrently ( suitable for SANs )
7- Transparent recovery from corruption or hardware failure.
8- Direct access from userland ( for DBMS, LDAP, and other userland
applications ). 
9- Plugins support ( like those of reiserfs 4).


If you know of any similar effort, or any technical obstacle I am
missing , please let me know.

Ramy



