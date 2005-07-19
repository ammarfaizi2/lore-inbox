Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVGSJMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVGSJMJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 05:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbVGSJMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 05:12:09 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:63334 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S261937AbVGSJMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 05:12:07 -0400
Message-ID: <42DCC454.7080706@tu-harburg.de>
Date: Tue, 19 Jul 2005 11:13:56 +0200
From: Jan Blunck <j.blunck@tu-harburg.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: 7eggert@gmx.de
CC: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ramfs: pretend dirent sizes
References: <4qoKs-6yv-13@gated-at.bofh.it> <4qoU5-6CQ-3@gated-at.bofh.it> <4qvsI-32Y-17@gated-at.bofh.it> <E1DtPzv-0002aA-8l@be1.lrz>
In-Reply-To: <E1DtPzv-0002aA-8l@be1.lrz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:
> Jan Blunck <j.blunck@tu-harburg.de> wrote:
> 
>>Andrew Morton wrote:
> 
> 
>> > Does it really matter?
>> >
>>
>>Yes! At least for me and my union mounts implementation.
> 
> 
> Is there a reason for not using size == link-count (or even static)?

Yes, the link count is only increased for subdirectories (because of the 
".." link) and not for regular files.

Jan
