Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265628AbUBBOTJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 09:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265636AbUBBOTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 09:19:09 -0500
Received: from ol.freeshell.org ([192.94.73.20]:32233 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S265628AbUBBOTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 09:19:07 -0500
Date: Mon, 2 Feb 2004 14:19:05 +0000 (UTC)
From: Ognen Duzlevski <maketo@sdf.lonestar.org>
X-X-Sender: maketo@mx.freeshell.org
To: linux-kernel@vger.kernel.org
Subject: real-time filesystem monitoring
Message-ID: <Pine.NEB.4.58.0402021412150.12346@mx.freeshell.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am working on a GPL-ed tool to monitor a filesystem in real time and
then perform a backup as soon as something has changed. In that direction
I tried FAM/libfam and dnotify and both choked on large directory
hierarchies. dnotify seems to require open file descriptors so it is not a
good solution unless one is to carefully control the number of the file
descriptors open and perform (sometimes large and slow) directory
re-reads every time there is some change (whose nature dnotify will not
report). I wanted to also port the code to Windows and provide a free
solution for its users and it turns out implementing such a solution on
Windows is much easier - there is a function called ReadDirectoryChangesW
which will notify an application every time there is a filesystem-wide
change and provide all information about this change. Anything similar on
Linux?

Thank you,
Ognen
