Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVBTXpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVBTXpR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 18:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbVBTXpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 18:45:17 -0500
Received: from [83.102.214.158] ([83.102.214.158]:7296 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S262115AbVBTXpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 18:45:11 -0500
X-Comment-To: Jan Blunck
To: Jan Blunck <j.blunck@tu-harburg.de>
Cc: Alex Tomas <alex@clusterfs.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] pdirops: vfs patch
References: <m34qg84em2.fsf@bzzz.home.net> <m3zmy02zq5.fsf@bzzz.home.net>
	<42191ED8.8030303@tu-harburg.de>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Mon, 21 Feb 2005 02:43:27 +0300
In-Reply-To: <42191ED8.8030303@tu-harburg.de> (Jan Blunck's message of "Mon,
 21 Feb 2005 00:35:52 +0100")
Message-ID: <m3acpy23xc.fsf@bzzz.home.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Jan Blunck (JB) writes:

 JB> With luck you have s_pdirops_size (or 1024) different renames altering
 JB> concurrently one directory inode. Therefore you need a lock protecting
 JB> your filesystem data. This is basically the job done by i_sem. So in
 JB> my opinion you only move "The Problem" from the VFS to the lowlevel
 JB> filesystems. But then there is no need for i_sem or your
 JB> s_pdirops_sems anymore.

1) i_sem protects dcache too
2) tmpfs has no "own" data, so we can use it this way (see 2nd patch)
3) I have pdirops patch for ext3, but it needs some cleaning ...

thanks, Alex

