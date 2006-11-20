Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030511AbWKTXeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030511AbWKTXeE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 18:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030529AbWKTXeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 18:34:04 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:55021 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030511AbWKTXeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 18:34:01 -0500
Date: Tue, 21 Nov 2006 00:30:36 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: jes@trained-monkey.org, Adrian Bunk <bunk@stusta.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: xconfig segfault
In-Reply-To: <45623803.7070103@oracle.com>
Message-ID: <Pine.LNX.4.64.0611210029140.6242@scrub.home>
References: <20061119161231.e509e5bf.randy.dunlap@oracle.com>
 <20061120004147.GC31879@stusta.de> <4560FB07.2040102@oracle.com>
 <20061120102438.94ff4b0a.randy.dunlap@oracle.com> <Pine.LNX.4.64.0611202254200.6242@scrub.home>
 <45623803.7070103@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 20 Nov 2006, Randy Dunlap wrote:

> > I cannot reproduce this. Could you try to run qconf within gdb for a
> > backtrace (adding -g to HOST_EXTRACFLAGS might get more useful output).
> 
> Sure, let me know what you want next.

Hmm, an uninitialize field is IMO the only thing that could go wrong here.

bye, Roman

---
 scripts/kconfig/qconf.cc |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/scripts/kconfig/qconf.cc
===================================================================
--- linux-2.6.orig/scripts/kconfig/qconf.cc
+++ linux-2.6/scripts/kconfig/qconf.cc
@@ -1259,6 +1259,7 @@ void ConfigSearchWindow::search(void)
  * Construct the complete config widget
  */
 ConfigMainWindow::ConfigMainWindow(void)
+	: searchWindow(0)
 {
 	QMenuBar* menu;
 	bool ok;
