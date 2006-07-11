Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965091AbWGKDMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbWGKDMS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 23:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965095AbWGKDMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 23:12:18 -0400
Received: from xenotime.net ([66.160.160.81]:14539 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965091AbWGKDMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 23:12:18 -0400
Date: Mon, 10 Jul 2006 20:15:06 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, hpa@zytor.com
Subject: Re: 2.6.18-rc1-mm1
Message-Id: <20060710201506.7abbca37.rdunlap@xenotime.net>
In-Reply-To: <200607102302_MC3-1-C4A4-1385@compuserve.com>
References: <200607102302_MC3-1-C4A4-1385@compuserve.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006 22:58:50 -0400 Chuck Ebbert wrote:

> On Sun, 9 Jul 2006 02:11:06 -0700, Andrew morton wrote:
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/
> 
> Warnings(?) during build:
> 
> /home/me/linux/2.6.18-rc1-mm1-64/scripts/Kbuild.klibc:315: target `usr/kinit/ipconfig' given more than once in the same rule.
> /home/me/linux/2.6.18-rc1-mm1-64/scripts/Kbuild.klibc:315: target `usr/kinit/nfsmount' given more than once in the same rule.
> /home/me/linux/2.6.18-rc1-mm1-64/scripts/Kbuild.klibc:315: target `usr/kinit/run-init' given more than once in the same rule.
> /home/me/linux/2.6.18-rc1-mm1-64/scripts/Kbuild.klibc:315: target `usr/kinit/fstype' given more than once in the same rule.

Yes, and these:

fs/ecryptfs/main.c:327: warning: format ‘%d’ expects type ‘int’, but argument 3 has type ‘size_t’
fs/ecryptfs/crypto.c:1599: warning: format ‘%d’ expects type ‘int’, but argument 2 has type ‘size_t’
fs/ecryptfs/crypto.c:1621: warning: format ‘%d’ expects type ‘int’, but argument 2 has type ‘size_t’
fs/ecryptfs/crypto.c:1628: warning: format ‘%d’ expects type ‘int’, but argument 2 has type ‘size_t’
fs/ecryptfs/crypto.c:1635: warning: format ‘%d’ expects type ‘int’, but argument 2 has type ‘size_t’
fs/ecryptfs/crypto.c:1642: warning: format ‘%d’ expects type ‘int’, but argument 2 has type ‘size_t’
fs/ecryptfs/crypto.c:1649: warning: format ‘%d’ expects type ‘int’, but argument 2 has type ‘size_t’
fs/ecryptfs/crypto.c:1656: warning: format ‘%d’ expects type ‘int’, but argument 2 has type ‘size_t’
drivers/acpi/executer/exmutex.c:268: warning: format ‘%X’ expects type ‘unsigned int’, but argument 4 has type ‘struct task_struct *’
drivers/acpi/executer/exmutex.c:268: warning: format ‘%X’ expects type ‘unsigned int’, but argument 6 has type ‘struct task_struct *’


I'll get to these sometime this week if noone else does.
(not the klibc warnings)

---
~Randy
