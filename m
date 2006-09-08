Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751878AbWIHHJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbWIHHJR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 03:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbWIHHJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 03:09:17 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:36480 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751878AbWIHHJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 03:09:16 -0400
Date: Fri, 8 Sep 2006 09:07:01 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrew Morton <akpm@osdl.org>
cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] proc: Make the generation of the self symlink table
 driven.
In-Reply-To: <20060907101512.3e3a9604.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0609080906380.22545@yvahk01.tjqt.qr>
References: <m1odttx8uz.fsf@ebiederm.dsl.xmission.com> <20060907101512.3e3a9604.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> +static struct pid_entry proc_base_stuff[] = {
>> +	NOD(PROC_TGID_INO, 	"self", S_IFLNK|S_IRWXUGO,
>> +		&proc_self_inode_operations, NULL, {}),
>> +	{}
>> +};
>
>We could save a bunch of bytes here.
>
>> +	/* Lookup the directory entry */
>> +	for (p = proc_base_stuff; p->name; p++) {
>
>By using ARRAY_SIZE here.
>
>> +	for (; nr < (ARRAY_SIZE(proc_base_stuff) - 1); filp->f_pos++, nr++) {
>
>like that does.

Also works without the () around ARRAY_SIZE(..)-1



Jan Engelhardt
-- 
