Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262871AbUCJXIN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 18:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbUCJXIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 18:08:12 -0500
Received: from piglet.student.utwente.nl ([130.89.161.100]:15490 "EHLO
	piglet.student.utwente.nl") by vger.kernel.org with ESMTP
	id S262885AbUCJXHu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 18:07:50 -0500
From: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH for testing] cow behaviour for hard links
Date: Thu, 11 Mar 2004 00:07:43 +0100
User-Agent: KMail/1.6.1
References: <20040310193429.GB4589@wohnheim.fh-wedel.de>
In-Reply-To: <20040310193429.GB4589@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403110007.43727.s.b.wielinga@student.utwente.nl>
X-Spam-Score: -4.9 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 March 2004 20:34, Jörn Engel wrote:
> Interna:
> I introduced a new flag for inodes, switching between normal behaviour
> and cow for hard links.  Flag can be changed and queried per fcntl().
> Ext[23] needed a bit of tweaking to write this flag to disk.  open()
> will fail, when a) cowlink flags is set, b) inode has more than one
> link and c) write access is requested.

I really like this! It makes me wonder why anyone hasn't come up with this 
idea before...

Pitifully, it only solves half of the problem: it does make sure you can't 
make any mistakes anymore, but it doesn't break the files up when a process 
wants to write to a linked file. You still have to copy and move every time 
you wish to edit a file. I'd like to have the kernel doing just that. I'll 
have a look whether I can write a patch, but I don't promise anything as I 
don't have much time :-)

Sytse
