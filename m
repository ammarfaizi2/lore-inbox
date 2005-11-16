Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932590AbVKPFo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbVKPFo2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 00:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbVKPFo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 00:44:27 -0500
Received: from dial169-252.awalnet.net ([213.184.169.252]:10255 "EHLO
	raad.intranet") by vger.kernel.org with ESMTP id S932587AbVKPFo1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 00:44:27 -0500
From: Al Boldi <a1426z@gawab.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 12/18] shared mount handling: bind and rbind
Date: Wed, 16 Nov 2005 08:35:28 +0300
User-Agent: KMail/1.5
Cc: Ram Pai <linuxram@us.ibm.com>, Miklos Szeredi <miklos@szeredi.hu>,
       Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, Rob Landley <rob@landley.net>
References: <E1EZInj-0001Ez-AV@ZenIV.linux.org.uk> <200511152129.04079.rob@landley.net> <Pine.LNX.4.64.0511151948570.13959@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511151948570.13959@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511160835.28636.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> This is why we have "pivot_root()" and "chroot()", which can both be used
> to do what you want to do. You mount the new root somewhere else, and then
> you chroot (or pivot-root) to it. And THEN you do 'chdir("/")' to move the
> cwd into the new root too (and only at that point have you "lost" the old
> root - although you can actually get it back if you have some file
> descriptor open to it).

Wouldn't this constitute a security flaw?

Shouldn't chroot jail you?

--
Al

