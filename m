Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbTDEN53 (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 08:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbTDEN53 (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 08:57:29 -0500
Received: from hera.cwi.nl ([192.16.191.8]:60047 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262258AbTDEN51 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 08:57:27 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 5 Apr 2003 16:08:58 +0200 (MEST)
Message-Id: <UTC200304051408.h35E8wl20163.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: Makefile bug
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A moment ago I again encountered the infamous
	Error inserting 'module.o': -1 Invalid module format

What is wrong this time? Hmm.
	version magic '2.5.65' should be '2.5.66'

Aha. So the command "make modules" given in a tree that used
to be 2.5.65 and was patched up to 2.5.66 fails to rebuild
modules.

The dependency goes
	foo.mod.c includes <linux/vermagic.h>
	<linux/vermagic.h> includes <linux/version.h>

(this happens for all modules, so is a generic makefile bug).

Andries
