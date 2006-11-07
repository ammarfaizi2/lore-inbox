Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752463AbWKGWA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463AbWKGWA6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 17:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752622AbWKGWA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 17:00:58 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33500 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1752463AbWKGWA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 17:00:57 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       olson@pathscale.com, akpm@osdl.org
Subject: Re: 2.6.19-rc4: known unfixed regressions (v3)
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
	<20061105064801.GV13381@stusta.de>
	<m1lkmpq5we.fsf@ebiederm.dsl.xmission.com>
	<20061107042214.GC8099@stusta.de> <45501730.8020802@serpentine.com>
	<m1psbzbpxw.fsf@ebiederm.dsl.xmission.com>
	<4550B22C.1060307@serpentine.com>
	<m18xinb1qn.fsf@ebiederm.dsl.xmission.com>
	<4550FB5D.5010804@serpentine.com>
Date: Tue, 07 Nov 2006 15:00:12 -0700
In-Reply-To: <4550FB5D.5010804@serpentine.com> (Bryan O'Sullivan's message of
	"Tue, 07 Nov 2006 13:32:13 -0800")
Message-ID: <m18xim9atv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bryan O'Sullivan" <bos@serpentine.com> writes:

> Eric W. Biederman wrote:
>
>> If you really need to write to both the config space registers and your
>> magic shadow copy of the register I can certainly do the config space
>> writes for you.
>
> Here's an updated copy of your second patch that does just that.
>
> I've also included a preview of the ipath patch that depends on this. With your
> original patch, my rework of your second patch, and the new ipath patch, the
> driver is back to working happily for me on top of current -git.
>
> I need to test the ipath patch on powerpc before I consider it cooked, but I
> won't have time to do that today.

Ok.  It looks good except you aren't calling ht_destroy_irq on driver unload.
Which is a small resource leak.

Cool looks like we have got this one.

Eric
