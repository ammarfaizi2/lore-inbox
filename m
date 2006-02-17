Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWBQQiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWBQQiv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 11:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWBQQiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 11:38:50 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:2223 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751139AbWBQQiu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 11:38:50 -0500
Date: Fri, 17 Feb 2006 17:38:43 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Lang <dlang@digitalinsight.com>
cc: Jesper Juhl <jesper.juhl@gmail.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: pid_t range question
In-Reply-To: <Pine.LNX.4.62.0602151238520.5446@qynat.qvtvafvgr.pbz>
Message-ID: <Pine.LNX.4.61.0602171737530.27452@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0602071122520.327@chaos.analogic.com>
 <m1pslystkz.fsf@ebiederm.dsl.xmission.com> 
 <Pine.LNX.4.61.0602091751220.30108@yvahk01.tjqt.qr><m1r76c2yhf.fsf@ebiederm.dsl.xmission.com><9a8748490602091213p2e020355ue516d59b7d0b6c81@mail.gmail.com>
 <Pine.LNX.4.61.0602101420550.31246@yvahk01.tjqt.qr>
 <Pine.LNX.4.62.0602151238520.5446@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Any of those 3 scheemes should keep pids below 6 digits as much as
>> > possible. We can still hit the cosmetic problem on boxes where more
>> > than 99999 processes are actually running at the same time, but most
>> > users will never encounter that.
>> > 
>> I'd say let's remain doing whatever we're doing now. That is, a maximum of
>> 32768 concurrent pids, and whoever needs more (e.g. Sourceforge shell,
>> etc.) can always raise it to their needs.
>
> when you say 'continue doing what we are doing now' do you mean to include the
> hard-coded limit of 32K pids? or do you mean to not worry about the cosmetic
> issue and change the code to not hard-code the limit, but instead honor a
> max_pid >32K?
>
Stay with the 32K limit. I doubt the majority of users ever exceeds 
creating 32767 simultaneous processes.


Jan Engelhardt
-- 
