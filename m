Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbUE3Kw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbUE3Kw7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 06:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUE3Kw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 06:52:59 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:10109 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262215AbUE3Kw5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 06:52:57 -0400
Date: Sun, 30 May 2004 12:55:02 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dan Kegel <dank@kegel.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: bringing back 'make symlinks'?
Message-ID: <20040530105502.GA19882@mars.ravnborg.org>
Mail-Followup-To: Dan Kegel <dank@kegel.com>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <40B36A0E.5080509@kegel.com> <20040525214328.GA2675@mars.ravnborg.org> <40B41367.5070607@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B41367.5070607@kegel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 08:47:51PM -0700, Dan Kegel wrote:
> 
> The way things are now, I can build toolchains for everything
> except the sh architecture (though my toolchain bootstrap script
> is ugly as noted due to the lack of 'make symlinks').

Does the following meet the needs of your cross-tool scripts?

	Sam

===== Makefile 1.492 vs edited =====
--- 1.492/Makefile	2004-05-30 08:24:06 +02:00
+++ edited/Makefile	2004-05-30 12:52:36 +02:00
@@ -632,6 +632,10 @@
 # All the preparing..
 prepare-all: prepare0 prepare
 
+# symlinks provided for compatibility with 2.4 - this allows boot-strapping
+# tool chains to be simpler
+symlinks: prepare-all
+
 #	Leave this as default for preprocessing vmlinux.lds.S, which is now
 #	done in arch/$(ARCH)/kernel/Makefile
 
