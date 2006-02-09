Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbWBIO0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbWBIO0F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 09:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbWBIO0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 09:26:05 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:29619 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932509AbWBIO0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 09:26:04 -0500
Message-ID: <43EB518F.6000905@openvz.org>
Date: Thu, 09 Feb 2006 17:28:31 +0300
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Jeff Dike <jdike@addtoit.com>
CC: linux-kernel@vger.kernel.org, saw@sawoct.com
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
References: <43E7C65F.3050609@openvz.org> <m1bqxh5qhb.fsf@ebiederm.dsl.xmission.com> <20060209021828.GC9456@ccure.user-mode-linux.org>
In-Reply-To: <20060209021828.GC9456@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>To deal with networking there are currently a significant number of
>>variables with static storage duration.  Making those variables global
>>and placing them in structures is neither as efficient as it could be
>>nor is it as maintainable as it should be.  Other subsystems have
>>similar problems.
> 
> 
> BTW, there is another solution, which you may or may not consider to
> be clean.
> 
> That is to load a separate copy of the subsystem (code and data) as a
> module when you want a new instance of it.  The code doesn't change,
> but you probably have to move it around some and provide some sort of
> interface to it.
> 
> I did this to the scheduler last year - see
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=111404726721747&w=2
It's really interesting!
Have you tested fairness of your solution and it's performance overhead?

Kirill

