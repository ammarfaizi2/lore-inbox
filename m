Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261518AbSKCAYl>; Sat, 2 Nov 2002 19:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261524AbSKCAYl>; Sat, 2 Nov 2002 19:24:41 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:17412 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S261518AbSKCAYk>;
	Sat, 2 Nov 2002 19:24:40 -0500
Date: Sat, 2 Nov 2002 19:31:08 -0500 (EST)
Message-Id: <200211030031.gA30V8a505209@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.kernel.org
Cc: tytso@mit.edu, olaf.dietsche#list.linux-kernel@t-online.de,
       dax@gurulabs.com
Subject: Re: Filesystem Capabilities in 2.6?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have to wonder, just how many setuid executables do people have?
Implementing filesystem capability bits in ramfs or tmpfs might do
the job. At boot, initramfs stuff puts a few trusted executables
in /trusted and sets the capability bits. Then "mount --bind" to
put /trusted/su over an empty /bin/su file, or use symlinks.

One might as well make "nosuid" the default then, and mount the
root filesystem that way. It's not as if a system needs to have
gigabytes of setuid executables.



