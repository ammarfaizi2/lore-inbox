Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVEQE6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVEQE6K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 00:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVEQE6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 00:58:10 -0400
Received: from ercist.iscas.ac.cn ([159.226.5.94]:11534 "EHLO
	ercist.iscas.ac.cn") by vger.kernel.org with ESMTP id S261684AbVEQE55
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 00:57:57 -0400
Subject: Re: [RFD] What error should FS return when I/O failure occurs?
From: fs <fs@ercist.iscas.ac.cn>
To: coywolf@lovecn.org
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Kenichi Okuyama <okuyama@intellilink.co.jp>
In-Reply-To: <2cd57c90050516155413b18b41@mail.gmail.com>
References: <1116263665.2434.69.camel@CoolQ>
	 <200505160635.j4G6ZUcX023810@turing-police.cc.vt.edu>
	 <20050517.051113.132843723.okuyamak@dd.iij4u.or.jp>
	 <2cd57c90050516155413b18b41@mail.gmail.com>
Content-Type: text/plain
Organization: iscas
Message-Id: <1116345974.2428.17.camel@CoolQ>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 17 May 2005 12:06:14 -0400
Content-Transfer-Encoding: 7bit
X-ArGoMail-Authenticated: fs@ercist.iscas.ac.cn
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-16 at 18:54, Coywolf Qi Hunt wrote:

> Two kinds of HW failure,
> 
>    1. still readable, only write failure. 
>    2. unreadable, unwriteable.
> 
> For the first case, if mount option errors=remount-ro is given or implied,
> EROFS is appropriate, otherwise EIO.  For the second case, always EIO.
> 
> The current VFS design does not try to hide the problems from its
> underlying fs'.
> No need to make it transparent. Userland programs need to consider
> both EROFS and EIO.
What you said is based on the FS implementor's perspective.
But from user's perspective, they open a file with O_RDWR, get a
success, then write returns EROFS?
Besides, EXT3 ALWAYS return EROFS for the 1st and 2nd case, even
you specify errors=continue, things are still the same.

regards,
----
Qu Fuping


