Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265382AbTAWQZ0>; Thu, 23 Jan 2003 11:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbTAWQZ0>; Thu, 23 Jan 2003 11:25:26 -0500
Received: from air-2.osdl.org ([65.172.181.6]:40631 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265382AbTAWQZY>;
	Thu, 23 Jan 2003 11:25:24 -0500
Date: Thu, 23 Jan 2003 08:29:09 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
cc: LKML <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel.
In-Reply-To: <200301231459.22789.schlicht@uni-mannheim.de>
Message-ID: <Pine.LNX.4.33L2.0301230825450.6515-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jan 2003, Thomas Schlichter wrote:

| I have writen a small kernel module and it works perfectly, but currently (I
| think it just begun with 2.5.59) I get the warning above when the module is
| inserted. Now I am just interested what I have to change so this message
| won't appear anymore...
|
| P.S.: If my Makefile or source will help I'll give it to you...
| -

Did you rebuild the module with a 2.5.59 Makefile?


Yes, it's a 2.5.59 change according to the Changelog at kernel.org:

<QUOTE>
<kai@tp1.ruhr-uni-bochum.de>
Module Sanity Check

This patch, based on Rusty's implementation,
adds a special section to vmlinux and all modules, which
contain the kernel version string, values of some
particularly important config options (SMP,preempt,proc
family) and the gcc version.

When inserting a module, the version string is checked against the
kernel version string and loading is rejected if they don't match.

The version string is actually added to the modules during the final
.ko generation, so that a changed version string does only cause relinking,
not recompilation, which is a major performance improvement over the old 2.4
way of doing things.
</QUOTE>


-- 
~Randy

