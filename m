Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbVAHGx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbVAHGx5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbVAHGwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:52:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:9350 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261917AbVAHFsm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:42 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632572250@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:37 -0800
Message-Id: <1105163257891@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.46, 2005/01/06 16:39:01-08:00, juhl-lkml@dif.dk

[PATCH] add printing of udev version to scripts/ver_linux

Since udev is starting to be used a lot of places and I've seen people get
asked about their udev version a few times on lkml I figured it was
perhaps time that scripts/ver_linux reported this info so it would get
into more bugreports by default.

This patch adds printing of udev version to scripts/ver_linux

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/Changes |   10 +++++++++-
 scripts/ver_linux     |    2 ++
 2 files changed, 11 insertions(+), 1 deletion(-)


diff -Nru a/Documentation/Changes b/Documentation/Changes
--- a/Documentation/Changes	2005-01-07 15:39:00 -08:00
+++ b/Documentation/Changes	2005-01-07 15:39:00 -08:00
@@ -223,6 +223,11 @@
 version v0.99.0 or higher. Running old versions may cause problems
 with programs using shared memory.
 
+Udev
+----
+Udev is a userspace application for populating /dev dynamically with
+only entries for devices actually present. Udev replaces devfs.
+
 Networking
 ==========
 
@@ -368,6 +373,10 @@
 ----------
 o  <http://powertweak.sourceforge.net/>
 
+Udev
+----
+o <http://www.kernel.org/pub/linux/utils/kernel/hotplug/>
+
 Networking
 **********
 
@@ -398,5 +407,4 @@
 NFS-Utils
 ---------
 o  <http://nfs.sourceforge.net/>
-
 
diff -Nru a/scripts/ver_linux b/scripts/ver_linux
--- a/scripts/ver_linux	2005-01-07 15:39:00 -08:00
+++ b/scripts/ver_linux	2005-01-07 15:39:00 -08:00
@@ -87,6 +87,8 @@
 
 expr --v 2>&1 | awk 'NR==1{print "Sh-utils              ", $NF}'
 
+udevinfo -V | awk '{print "udev                  ", $3}'
+
 if [ -e /proc/modules ]; then
     X=`cat /proc/modules | sed -e "s/ .*$//"`
     echo "Modules Loaded         "$X

