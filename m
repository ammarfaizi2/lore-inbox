Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbUKHS7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbUKHS7a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 13:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbUKHS6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 13:58:23 -0500
Received: from fe05.axelero.hu ([195.228.240.93]:10514 "EHLO fe05.axelero.hu")
	by vger.kernel.org with ESMTP id S261196AbUKHS5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 13:57:40 -0500
From: pageexec@freemail.hu
To: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
Date: Mon, 08 Nov 2004 19:56:26 +0100
MIME-Version: 1.0
Subject: RE: KSTK_EIP and KSTK_ESP
Reply-to: pageexec@freemail.hu
CC: <linux-kernel@vger.kernel.org>
Message-ID: <418FCF6A.4368.2314122E@localhost>
In-reply-to: <C863B68032DED14E8EBA9F71EB8FE4C20542D290@azsmsx406>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Shouldn't the ESP value pointed to by KSTK_ESP() point to the beginning of
> the pt_regs structure for the user space application?

first of all, anything can be on the userland stack at the time the
app issued a syscall. but you don't have to bother with the userland
stack at all, pt_regs is created on the kernel stack, check out the
SAVE_ALL macro (and its uses) in arch/i386/kernel/entry.S .

