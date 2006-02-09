Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbWBIPqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbWBIPqg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 10:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbWBIPqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 10:46:36 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:33824 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932553AbWBIPqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 10:46:36 -0500
Message-ID: <43EB6474.60903@sw.ru>
Date: Thu, 09 Feb 2006 18:49:08 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Jeff Dike <jdike@addtoit.com>
CC: Kirill Korotaev <dev@openvz.org>, linux-kernel@vger.kernel.org,
       saw@sawoct.com
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
References: <43E7C65F.3050609@openvz.org> <m1bqxh5qhb.fsf@ebiederm.dsl.xmission.com> <20060209021828.GC9456@ccure.user-mode-linux.org> <43EB518F.6000905@openvz.org> <20060209154046.GA3814@ccure.user-mode-linux.org>
In-Reply-To: <20060209154046.GA3814@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>I did this to the scheduler last year - see
>>>	http://marc.theaimsgroup.com/?l=linux-kernel&m=111404726721747&w=2
>>
>>It's really interesting!
>>Have you tested fairness of your solution and it's performance overhead?
> 
> 
> What do you mean by fairness, exactly?
I mean how CPU time is distributed not only in the case of CPU hogs. For 
example, when 2 tasks do cyclic 1 byte transfer via pipe. one of them is 
awake, while another goes to sleep.
If both are in one container, will they behave like a CPU hog?

> As for its overhead, I just got it working inside UML.  I tried it on
> x86_64, but something was wrong with the low-level switching stuff,
> and the machine hung whenever a guest scheduler process tried to run.
> So, I never got any real measurements.
It's a pity... :( We have fair CPU scheduler in OpenVZ project, so it's 
quite an interesting approach for us.

Kirill

