Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269047AbTGJIDW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 04:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269043AbTGJIDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 04:03:21 -0400
Received: from f16.mail.ru ([194.67.57.46]:10764 "EHLO f16.mail.ru")
	by vger.kernel.org with ESMTP id S269047AbTGJICS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 04:02:18 -0400
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Are =?koi8-r?Q?=22?=,=?koi8-r?Q?=22=20?=and =?koi8-r?Q?=22?=..=?koi8-r?Q?=22=20?=in directory required=?koi8-r?Q?=3F?=
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Thu, 10 Jul 2003 12:16:56 +0400
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19aWbo-00031x-00.arvidjaar-mail-ru@f16.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is it possible for readdir to return really empty directory - without
and entry, even "." and ".."?

The reason is, to enable full FAM/dnotify support for supermount I
have to allow open of non-mounted root and - if possible - readdir
in this case. Any attepmpt to simulate "." and ".." in this case
will result in races between kernel/user space, so the best case
would be just return nothing (meaning empty directory).

TIA

-andrey
