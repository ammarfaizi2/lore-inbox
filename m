Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754164AbWKGQT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164AbWKGQT5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 11:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754205AbWKGQT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 11:19:57 -0500
Received: from mx.pathscale.com ([64.160.42.68]:4791 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1754164AbWKGQT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 11:19:56 -0500
Message-ID: <4550B22C.1060307@serpentine.com>
Date: Tue, 07 Nov 2006 08:19:56 -0800
From: "Bryan O'Sullivan" <bos@serpentine.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc4: known unfixed regressions (v3)
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>	<20061105064801.GV13381@stusta.de>	<m1lkmpq5we.fsf@ebiederm.dsl.xmission.com>	<20061107042214.GC8099@stusta.de> <45501730.8020802@serpentine.com> <m1psbzbpxw.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1psbzbpxw.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> How comes the driver fixes in the context of my patches?

The fix is simple enough, it's just not as clean as I'd like.  I have to 
pull apart the contents of the ht_irq_msg that the new update hook is 
getting passed, in order to get the vector out, so that I can reprogram 
the offending chip register after I've done the config space writes. 
It's a pretty roundabout way to do the job.

	<b
