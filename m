Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWHPOux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWHPOux (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 10:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWHPOux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 10:50:53 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:670 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751191AbWHPOuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 10:50:52 -0400
Date: Wed, 16 Aug 2006 16:48:58 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       containers@lists.osdl.org
Subject: Re: [PATCH 2/7] proc: Modify proc_pident_lookup to be completely
 table driven.
In-Reply-To: <11556651312499-git-send-email-ebiederm@xmission.com>
Message-ID: <Pine.LNX.4.61.0608161646510.23266@yvahk01.tjqt.qr>
References: <m1u04d98wa.fsf@ebiederm.dsl.xmission.com>
 <11556651312499-git-send-email-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	0.0 UPPERCASE_25_50        message body is 25-50% uppercase
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
>-#define E(type,name,mode) {(type),sizeof(name)-1,(name),(mode)}
>+#define NOD(TYPE, NAME, MODE, IOP, FOP, OP) {		\
>+	.type = (TYPE),					\
>+	.len  = sizeof(NAME) - 1,			\
>+	.name = (NAME),					\
>+	.mode = MODE,					\
>+	.iop  = IOP,					\
>+	.fop  = FOP,					\
>+	.op   = OP,					\
>+}

Please () around MODE IOP FOP and OP, just like it's already done
with TYPE and NAME.



Jan Engelhardt
-- 
