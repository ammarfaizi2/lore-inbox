Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbULFB2C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbULFB2C (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 20:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbULFB2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 20:28:02 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:11790 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261444AbULFB2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 20:28:00 -0500
Date: Mon, 6 Dec 2004 02:27:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       selinux@tycho.nsa.gov
Subject: Re: [2.6 patch] selinux: possible cleanups
Message-ID: <20041206012745.GP2953@stusta.de>
References: <20041128190139.GD4390@stusta.de> <1102089296.29971.110.camel@moss-spartans.epoch.ncsc.mil> <20041206004831.GM2953@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041206004831.GM2953@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot the patch (on top of the main patch):


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/security/selinux/ss/avtab.c.old	2004-12-06 01:49:40.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/security/selinux/ss/avtab.c	2004-12-06 01:49:54.000000000 +0100
@@ -54,7 +54,7 @@
 	return newnode;
 }
 
-int avtab_insert(struct avtab *h, struct avtab_key *key, struct avtab_datum *datum)
+static int avtab_insert(struct avtab *h, struct avtab_key *key, struct avtab_datum *datum)
 {
 	int hvalue;
 	struct avtab_node *prev, *cur, *newnode;

