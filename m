Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbTGBWrv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 18:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265009AbTGBWru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 18:47:50 -0400
Received: from main.gmane.org ([80.91.224.249]:8922 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264980AbTGBWqV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 18:46:21 -0400
Mail-Followup-To: linux-kernel@vger.kernel.org
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: ilmari@ilmari.org (Dagfinn Ilmari =?iso-8859-1?q?Manns=E5ker?=)
Subject: Re: Linux 2.5.74
Date: Thu, 03 Jul 2003 00:58:15 +0200
Organization: Program-, Informasjons- og Nettverksteknologisk Gruppe, UiO
Message-ID: <d8jfzlo1qpk.fsf@wirth.ping.uio.no>
References: <Pine.LNX.4.44.0307021433520.2323-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@main.gmane.org
Cc: torvalds@osdl.org, thornber@sistina.com
Mail-Copies-To: never
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
Cancel-Lock: sha1:WLpABwttD31CaBOHF61cWmL4Eks=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Joe Thornber:
>   o dm: remove bogus yields

This change requires io_schedule to be exported for modular dm to work.

--- kernel/ksyms.c~     2003-07-02 22:40:07.000000000 +0200
+++ kernel/ksyms.c      2003-07-03 00:36:59.000000000 +0200
@@ -462,6 +462,7 @@
 #endif
 EXPORT_SYMBOL(schedule_timeout);
 EXPORT_SYMBOL(yield);
+EXPORT_SYMBOL(io_schedule);
 EXPORT_SYMBOL(__cond_resched);
 EXPORT_SYMBOL(set_user_nice);
 EXPORT_SYMBOL(task_nice);


-- 
ilmari

