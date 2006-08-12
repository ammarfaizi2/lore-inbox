Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbWHLKgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbWHLKgq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 06:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWHLKgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 06:36:46 -0400
Received: from mail.aknet.ru ([82.179.72.26]:39428 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S932500AbWHLKgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 06:36:46 -0400
Message-ID: <44DDAF04.70606@aknet.ru>
Date: Sat, 12 Aug 2006 14:35:48 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Zachary Amsden <zach@vmware.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jan Beulich <jbeulich@novell.com>
Subject: Re: + espfix-code-cleanup.patch added to -mm tree
References: <200608112230_MC3-1-C7D2-A98F@compuserve.com>
In-Reply-To: <200608112230_MC3-1-C7D2-A98F@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Chuck Ebbert wrote:
> It's really not that hard to get the limit:
>         limit_in_bytes = new_esp | (THREAD_SIZE - 1)
>         limit_in_pages = limit_in_bytes >> 12
I was worrying about a corner cases. The new_esp can
be just everything. It can be < THREAD_SIZE, in which
case the limit_in_pages will be 0. Or, I beleive, it
can even be a negative value, which will turn into a
a value larger than the old_esp.
But after calculating a few examples, I have almost
convinced myself that your technique will work in all
such a cases. So I'll try that as soon as the new -mm's
will boot for me again.

