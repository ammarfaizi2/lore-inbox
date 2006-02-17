Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161158AbWBQVlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161158AbWBQVlF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 16:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161157AbWBQVlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 16:41:04 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64946 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161155AbWBQVlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 16:41:01 -0500
To: David Lang <dlang@digitalinsight.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: pid_t range question
References: <Pine.LNX.4.61.0602071122520.327@chaos.analogic.com>
	<m1pslystkz.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.61.0602091751220.30108@yvahk01.tjqt.qr>
	<m1r76c2yhf.fsf@ebiederm.dsl.xmission.com>
	<9a8748490602091213p2e020355ue516d59b7d0b6c81@mail.gmail.com>
	<Pine.LNX.4.61.0602101420550.31246@yvahk01.tjqt.qr>
	<Pine.LNX.4.62.0602151238520.5446@qynat.qvtvafvgr.pbz>
	<Pine.LNX.4.61.0602171737530.27452@yvahk01.tjqt.qr>
	<Pine.LNX.4.62.0602171201020.8348@qynat.qvtvafvgr.pbz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 17 Feb 2006 14:39:55 -0700
In-Reply-To: <Pine.LNX.4.62.0602171201020.8348@qynat.qvtvafvgr.pbz> (David
 Lang's message of "Fri, 17 Feb 2006 13:20:36 -0800 (PST)")
Message-ID: <m17j7toeac.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang <dlang@digitalinsight.com> writes:

> I agree that the mojority of users don't hit this limit, but I've got a couple
> of boxes that push it (they run out of ram before that, but more ram is on
> order).
>
> however it sounds like switching to a 64 bit kernel will avoid this limit, so
> I'll put my efforts into configuring a box to do that.

That is what I would recommend.  Unless you do something weird an painful
like configure a kernel doing the 4G/4G split a 32bit box is going to
have memory problems with more than 32K tasks.

Just remember you need push up /proc/sys/kernel/pid-max to raise the default
on a 64bit box.

Eric
