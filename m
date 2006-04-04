Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWDDTjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWDDTjp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 15:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWDDTjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 15:39:45 -0400
Received: from mtaout2.012.net.il ([84.95.2.4]:3250 "EHLO mtaout2.012.net.il")
	by vger.kernel.org with ESMTP id S1750749AbWDDTjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 15:39:45 -0400
Date: Tue, 04 Apr 2006 22:38:55 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: 2.6.17-rc1-mm1: KEXEC became SMP-only
In-reply-to: <4432C7AC.9020106@vmware.com>
To: Zachary Amsden <zach@vmware.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net, fastboot@osdl.org
Message-id: <20060404193855.GC1221@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20060404014504.564bf45a.akpm@osdl.org>
 <20060404162921.GK6529@stusta.de> <m1acb15ja2.fsf@ebiederm.dsl.xmission.com>
 <4432B22F.6090803@vmware.com> <m1irpp41wx.fsf@ebiederm.dsl.xmission.com>
 <4432C7AC.9020106@vmware.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 12:23:24PM -0700, Zachary Amsden wrote:

> This gets rid of both the code duplication and makes it somewhat more 
> obvious what is going on - plus it is easy to extend to other functions, 
> and as a bonus feature, you don't need to change any code in other 
> subarchitectures if you need to add a new hook.

ppc has 'struct machdep_calls' (asm-powerpc/machdep.h) which serves
the same purpose, and it's indeed a clean way of doing this sort of
thing.

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/
