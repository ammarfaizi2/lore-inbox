Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWA3J3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWA3J3s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWA3J3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:29:48 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:8333 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932162AbWA3J3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:29:47 -0500
Date: Mon, 30 Jan 2006 10:29:40 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pid: Don't hash pid 0.
In-Reply-To: <m1ek2rfsu9.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.61.0601301028510.6405@yvahk01.tjqt.qr>
References: <m1ek2rfsu9.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>@@ -148,6 +148,9 @@ int fastcall attach_pid(task_t *task, en
> {
> 	struct pid *pid, *task_pid;
> 
>+	if (!nr)
>+		goto out;
>+

How about nr==0, it would make it more obvious.



Jan Engelhardt
-- 
