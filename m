Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbWG2TCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWG2TCr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 15:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWG2TCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 15:02:47 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:21968 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751410AbWG2TCr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 15:02:47 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17611.44980.749591.920980@gargle.gargle.HOWL>
Date: Sat, 29 Jul 2006 22:57:56 +0400
To: David Masover <ninja@slaphack.com>
Cc: Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@osdl.org>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: metadata plugins (was Re: the " 'official' point of view" expressed
 by kernelnewbies.org regarding reiser4 inclusion)
In-Reply-To: <44CBA99F.2040306@slaphack.com>
References: <200607281402.k6SE245v004715@laptop13.inf.utfsm.cl>
	<44CA31D2.70203@slaphack.com>
	<Pine.LNX.4.64.0607280859380.4168@g5.osdl.org>
	<44C9FB93.9040201@namesys.com>
	<44CA6905.4050002@slaphack.com>
	<44CA126C.7050403@namesys.com>
	<44CA8771.1040708@slaphack.com>
	<44CABB87.3050509@namesys.com>
	<17611.21640.208153.492074@gargle.gargle.HOWL>
	<44CBA99F.2040306@slaphack.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
X-SystemSpamProbe: GOOD 0.0000024 64102dd075072300a06ff0933faa34a1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover writes:
 > Nikita Danilov wrote:
 > 
 > > As you see, ext2 code already has multiple file "plugins", with
 > > persistent "plugin id" (stored in i_mode field of on-disk struct
 > > ext2_inode).
 > 
 > Aha!  So here's another question:  Is it fair to ask Reiser4 to make its
 > plugins generic, or should we be asking ext2/3 first?

ext2/3 plugins are generic: in Linux every file system can implement
per-object behavior by specifying
{file,inode,dentry,address_space}_operations. This mechanism is provided
by VFS (and, in fact, is the only way that VFS interacts with file
system) and is completely generic.

 > 

Nikita.

