Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbTESQ5W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 12:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbTESQ5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 12:57:22 -0400
Received: from terminus.zytor.com ([63.209.29.3]:6114 "EHLO terminus.zytor.com")
	by vger.kernel.org with ESMTP id S262489AbTESQ5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 12:57:16 -0400
Message-ID: <3EC90FE8.4000504@zytor.com>
Date: Mon, 19 May 2003 10:10:00 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Andrey Borzenkov <arvidjaar@mail.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] submount: another removeable media handler
References: <E19HiEl-000D0k-00.arvidjaar-mail-ru@f25.mail.ru>
In-Reply-To: <E19HiEl-000D0k-00.arvidjaar-mail-ru@f25.mail.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Borzenkov wrote:
> 
>>Basically, in my opinion removable media should be handled by insert
>>and removal detection, not by access detection.  Obviously, there are
>>some sticky issues with that in the case where media can be removed
>>without notice (like PC floppies or other manual-eject devices), but
>>overall I think that is the correct approach.
> 
> 
> You are absolutely right. Unfortunately, I am not aware of any general
> way to request device to notify about media insertion/ejection.
> Without such notification the only thing you can do is to poll - and
> this is the same access detection in disguise. With disatvantage
> that polling wastes system resources and is subject to races.
> 

No, that is not correct.  Polling for insertion is different from 
probing from access.  There isn't a *general* way to obtain 
notification, but may devices offer it, so you need to develop a modular 
way to deal with it.

	-hpa

