Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262189AbVAAEPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbVAAEPz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 23:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVAAEPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 23:15:55 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:5062 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S262189AbVAAEPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 23:15:52 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
       sam@ravnborg.org, pmarques@grupopie.com
Subject: Re: sh: inconsistent kallsyms data 
In-reply-to: Your message of "Sat, 01 Jan 2005 14:59:19 +1100."
             <7184.1104551959@ocs3.ocs.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 01 Jan 2005 15:15:35 +1100
Message-ID: <8025.1104552935@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 01 Jan 2005 14:59:19 +1100, 
Keith Owens <kaos@ocs.com.au> wrote:
>Paul, please test this patch.  Build with CONFIG_KALLSYMS_ALL=n and
>CONFIG_KALLSYMS_EXTRA_PASS=n.

ps.  Due to bugs in the kernel build system, you cannot assume that
changing scripts/kallsyms.c or CONFIG_KALLSYMS_ALL or
CONFIG_KALLSYMS_EXTRA_PASS will be automatically detected.  The make
dependency tree for the kallsyms code is incomplete.

After applying the patch and adjusting the config, touch init/main.c
then make.  Touching a file will force a kernel relink and work around
the incomplete dependency data.

