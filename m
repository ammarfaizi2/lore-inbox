Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264787AbTE1QC5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 12:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264788AbTE1QC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 12:02:57 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:49343 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264787AbTE1QCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 12:02:55 -0400
Message-ID: <3ED4E0BB.2080603@colorfullife.com>
Date: Wed, 28 May 2003 18:15:55 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arvind.kan@wipro.com
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       "indou.takao" <indou.takao@jp.fujitsu.com>, rml <rml@tech9.net>,
       Dave Jones <davej@suse.de>
Subject: Re: Changing SEMVMX to a tunable parameter
References: <3ED4C6B6.7050806@wipro.com>
In-Reply-To: <3ED4C6B6.7050806@wipro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arvind Kandhare wrote:

>
> >>How?
> > > SEMVMX is right now 32k, because the value is stored in an signed
> > > short,
> > > both internally and in the SuSv2 ABI.
>
>
> semval is a part of struct sem and it is an integer as of now (2.5.69).
> That is, it doesn't comply with SuS v3 as far as data type is concerned.
>
> SuS v3 specifies semval to be an unsigned short.i.e. we can have a 
> maximum of 64K on this.

Ok, thus you want to increase it from 32k to 64k, but not beyond, correct?
You'd have to check that there are no hidden signed/unsigned assumptions 
in ipc/sem.c

>
> Irrespective of the maximum value, an option to tune this limit would be
> highly desirable.

_If_ there are no signed/unsigned problems and if Oracle wants 64K, then 
I would increase SEMVMX to 64K, without making it tunable. Dito for SEMAEM.

--
    Manfred

