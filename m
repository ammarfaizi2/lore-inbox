Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271877AbRH1SAE>; Tue, 28 Aug 2001 14:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267650AbRH1R7x>; Tue, 28 Aug 2001 13:59:53 -0400
Received: from chello212017081026.15.vie.surfer.at ([212.17.81.26]:56829 "EHLO
	nerd.clifford.at") by vger.kernel.org with ESMTP id <S271878AbRH1R7o>;
	Tue, 28 Aug 2001 13:59:44 -0400
Date: Tue, 28 Aug 2001 20:04:32 +0200 (CEST)
From: Clifford Wolf <clifford@clifford.at>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: <Remy.Card@linux.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Ext2FS: SUID on Dir
In-Reply-To: <200108281549.f7SFnPg263571@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.33.0108281959040.11558-100000@nerd.clifford.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> It would at least be more logical to have SUID do for user IDs
> what SGID does for group IDs.

Maybe - but at least I can't thing of any situation where that could be
needed.

> Having SUID muck with group IDs is pretty ugly.

It doesn't. It "mucks" with the group field in the file mode, it doesn't
do anything to the group id.

To be more exact: It copies the permissions from the user field in the
file mode to the group field in the file mode. Imo that is not far away
from the meaning of a SUID bit on programms: It gives the rights from the
user who owns the file to a wider range of users ..

yours,
 - clifford

--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
Clifford Wolf ................ www.clifford.at         IRC: http://opirc.nu
The ROCK Projects Workgroup .. www.rock-projects.com  Tel: +43-699-10063494
The ROCK Linux Workgroup ..... www.rocklinux.org      Fax: +43-2235-42788-4
The NTx Consulting Group ..... www.ntx.at            email: god@clifford.at

Reality corrupted. Reboot universe? (Y/N)                 www.rocklinux.net

