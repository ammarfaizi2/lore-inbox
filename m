Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbTJRWmc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 18:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbTJRWmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 18:42:31 -0400
Received: from [213.4.129.129] ([213.4.129.129]:28987 "EHLO tsmtp9.mail.isp")
	by vger.kernel.org with ESMTP id S261898AbTJRWma convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 18:42:30 -0400
Date: Sun, 19 Oct 2003 00:41:24 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: wli@holomorphy.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: reproduceable oops in -test8
Message-Id: <20031019004124.2752f1ed.diegocg@teleline.es>
In-Reply-To: <20031019003241.66bceaa0.aradorlinux@yahoo.es>
References: <20031018234848.51a2b723.aradorlinux@yahoo.es>
	<20031018215729.GK25291@holomorphy.com>
	<20031019003241.66bceaa0.aradorlinux@yahoo.es>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sun, 19 Oct 2003 00:32:41 +0200 Diego Calleja García <aradorlinux@yahoo.es> escribió:

> o If you run ps ax, i'll hang too:
> stat64("/proc/572", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
> open("/proc/572/stat", O_RDONLY)        = 6
> read(6, 

After that, doing:
# cd /proc/572
# ls -lR
<...>
getxattr("fd", "system.posix_acl_access", (nil), 0) = -1 EOPNOTSUPP (Operation not supported)
lstat64("environ", {st_mode=S_IFREG|0400, st_size=0, ...}) = 0
getxattr("environ", "system.posix_acl_access", (nil), 0) = -1 EOPNOTSUPP (Operation not supported)
lstat64("auxv", {st_mode=S_IFREG|0400, st_size=0, ...}) = 0
getxattr("auxv", "system.posix_acl_access", (nil), 0) = -1 EOPNOTSUPP (Operation not supported)
lstat64("status", {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
getxattr("status", "system.posix_acl_access", (nil), 0) = -1 EOPNOTSUPP (Operation not supported)
lstat64("cmdline", {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
getxattr("cmdline", "system.posix_acl_access", (nil), 0) = -1 EOPNOTSUPP (Operation not supported)
lstat64("stat", {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
getxattr("stat", "system.posix_acl_access", (nil), 0) = -1 EOPNOTSUPP (Operation not supported)
lstat64("statm", {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
getxattr("statm", "system.posix_acl_access", (nil), 0) = -1 EOPNOTSUPP (Operation not supported)
lstat64("maps", {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
getxattr("maps", "system.posix_acl_access", (nil), 0) = -1 EOPNOTSUPP (Operation not supported)
lstat64("mem", {st_mode=S_IFREG|0600, st_size=0, ...}) = 0
getxattr("mem", "system.posix_acl_access", (nil), 0) = -1 EOPNOTSUPP (Operation not supported)
lstat64("cwd", {st_mode=S_IFLNK|0777, st_size=0, ...}) = 0
readlink("cwd", "/home/diego", 128)     = 11
lstat64("root", {st_mode=S_IFLNK|0777, st_size=0, ...}) = 0
readlink("root", "/", 128)              = 1
lstat64("exe", {st_mode=S_IFLNK|0777, st_size=0, ...}) = 0
readlink("exe", 

Also it hangs here.



Diego Calleja
