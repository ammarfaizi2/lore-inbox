Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbTHYSJO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 14:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbTHYSIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 14:08:45 -0400
Received: from [62.241.33.80] ([62.241.33.80]:36101 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262076AbTHYSI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 14:08:27 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: "J.A. Magallon" <jamagallon@able.es>, "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH] add seq_file "single" interfaces
Date: Mon, 25 Aug 2003 20:07:10 +0200
User-Agent: KMail/1.5.3
Cc: marcelo@conectiva.com.br, lkml <linux-kernel@vger.kernel.org>,
       johnstul@us.ibm.com, jamesclv@us.ibm.com
References: <20030825100310.3c96fd68.rddunlap@osdl.org> <20030825175728.GA2199@werewolf.able.es>
In-Reply-To: <20030825175728.GA2199@werewolf.able.es>
MIME-Version: 1.0
Message-Id: <200308252005.56521.m.c.p@wolk-project.de>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OBlS/CIN+jRjd9I"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_OBlS/CIN+jRjd9I
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 25 August 2003 19:57, J.A. Magallon wrote:

> > This patch adds the seq_file "single" interfaces from 2.6.0-test4
> > to 2.4.22++.  This will enable larger /proc/interrupts and
> > /proc/mdstat, which currently have some oopsing problems
> > with large outputs.
> > Please apply.

> How about exporting them in kernel/ksyms ?

Right.

ciao, Marc



--Boundary-00=_OBlS/CIN+jRjd9I
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="seq-file-for-single-open-exports.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="seq-file-for-single-open-exports.patch"

--- a/kernel/ksyms.c	Thu Apr 17 10:42:17 2003
+++ b/kernel/ksyms.c	Thu Apr 17 14:49:54 2003
@@ -515,6 +515,10 @@ EXPORT_SYMBOL(seq_open);
 EXPORT_SYMBOL(seq_release);
 EXPORT_SYMBOL(seq_read);
 EXPORT_SYMBOL(seq_lseek);
+EXPORT_SYMBOL(seq_path);
+EXPORT_SYMBOL(single_open);
+EXPORT_SYMBOL(single_release);
+EXPORT_SYMBOL(seq_release_private);
 
 /* Program loader interfaces */
 EXPORT_SYMBOL(setup_arg_pages);

--Boundary-00=_OBlS/CIN+jRjd9I--

