Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264053AbTH2Ftv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 01:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbTH2Ftv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 01:49:51 -0400
Received: from tmi.comex.ru ([217.10.33.92]:52621 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S264053AbTH2Ftu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 01:49:50 -0400
X-Comment-To: Mike Fedyk
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [RFC] extents support for EXT3
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
References: <m33cfm19ar.fsf@bzzz.home.net>
	<20030828172214.GC21352@matchmail.com>
Date: Fri, 29 Aug 2003 09:55:15 +0400
Message-ID: <m31xv5t3cs.fsf@bzzz.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Mike Fedyk (MF) writes:

 MF> With extents, what are the worst/best cases for max file size on a 1k block
 MF> filesystem?  AFAICT, worst case is 16GB if it backs out to the second level
 MF> like we have now...

well, for extents case the worst/best cases are function of block allocation. 
in fact, the best case could have ~31000 blocks per extent (limited by groups).
the worst case is having 1 block per extent -> 12 bytes per block (4 bytes
w/o extents)

