Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbUBXLLY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 06:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbUBXLLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 06:11:24 -0500
Received: from users.linvision.com ([62.58.92.114]:9137 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262226AbUBXLKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 06:10:44 -0500
Date: Tue, 24 Feb 2004 12:10:41 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Gautam Pagedar <gautam@cins.unipune.ernet.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: can i modify ls
Message-ID: <20040224111041.GA25565@bitwizard.nl>
References: <005601c3fd75$1c681510$8c01080a@crayii>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005601c3fd75$1c681510$8c01080a@crayii>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 28, 2004 at 02:33:00AM +0530, Gautam Pagedar wrote:
>    i am new to this mailing list, so please bear with me if i don't follow
> certain rules till i get used to it.  I am a research student and currently
> working on a project to tweak the working of 'ls' command depending on my
> requirement. I have observed that 'ls' show ALL THE FILES and DIRECTORIES in
> a particular location even though a user has no access rights to it. I want
> to hide all
> such files for that particular user.

It already works like you expect it to do:

erik@zurix:/tmp/test >mkdir a b
erik@zurix:/tmp/test >touch a/c
erik@zurix:/tmp/test >ls -lR
.:
total 1
drwxr-xr-x    2 erik     users          72 Feb 24 11:49 a/

./a:
total 0
-rw-r--r--    1 erik     users           0 Feb 24 11:49 c

erik@zurix:/tmp/test >chmod -r a
erik@zurix:/tmp/test >ls -lR
.:
total 1
d-wx--x--x    2 erik     users          72 Feb 24 11:49 a/

ls: ./a: Permission denied
erik@zurix:/tmp/test >chmod -x a
erik@zurix:/tmp/test >cd a
a: Permission denied.



Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
