Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWG2Mdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWG2Mdv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 08:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWG2Mdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 08:33:51 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:58067 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932124AbWG2Mdu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 08:33:50 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17611.21640.208153.492074@gargle.gargle.HOWL>
Date: Sat, 29 Jul 2006 16:28:56 +0400
To: Hans Reiser <reiser@namesys.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: metadata plugins (was Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion)
Newsgroups: gmane.comp.file-systems.reiserfs.general,gmane.linux.kernel
In-Reply-To: <44CABB87.3050509@namesys.com>
References: <200607281402.k6SE245v004715@laptop13.inf.utfsm.cl>
	<44CA31D2.70203@slaphack.com>
	<Pine.LNX.4.64.0607280859380.4168@g5.osdl.org>
	<44C9FB93.9040201@namesys.com>
	<44CA6905.4050002@slaphack.com>
	<44CA126C.7050403@namesys.com>
	<44CA8771.1040708@slaphack.com>
	<44CABB87.3050509@namesys.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
X-SystemSpamProbe: GOOD 0.0000019 96dd843a5e5211f1f70afe9fec471e0b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser writes:
 > David Masover wrote:
 > 
 > >
 > > If indeed it can be changed easily at all.  I think the burden is on
 > > you to prove that you can change it to be more generic, rather than
 > > saying "Well, we could do it later, if people want us to..."
 > 
 > None of the filesystems other than reiser4 have any interest in using
 > plugins, and this whole argument over how it should be in VFS is
 > nonsensical because nobody but us has any interest in using the
 > functionality.  The burden is on the generic code authors to prove that
 > they will ever ever do anything at all besides complain.  Frankly, I
 > don't think they will.  I think they will never produce one line of code.
 > 
 > Please cite one ext3 developer who is signed up to implement ext3 using
 > plugins if they are supported by VFS.

In fact, they all do:

struct inode_operations ext2_file_inode_operations;
struct inode_operations ext2_dir_inode_operations;
struct inode_operations ext2_special_inode_operations;
struct inode_operations ext2_symlink_inode_operations;
struct inode_operations ext2_fast_symlink_inode_operations;

As you see, ext2 code already has multiple file "plugins", with
persistent "plugin id" (stored in i_mode field of on-disk struct
ext2_inode).

 > 
 > Hans
 > 

Nikita.

