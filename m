Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbVITPdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbVITPdZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 11:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbVITPdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 11:33:25 -0400
Received: from truxi.wincor-nixdorf.com ([217.115.67.78]:63447 "EHLO
	truxi.wincor-nixdorf.com") by vger.kernel.org with ESMTP
	id S965045AbVITPdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 11:33:24 -0400
Message-ID: <43302BA1.5090109@wincor-nixdorf.com>
Date: Tue, 20 Sep 2005 17:32:49 +0200
From: Peter Duellings <Peter.Duellings@wincor-nixdorf.com>
Organization: Wincor Nixdorf
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.1) Gecko/20040707
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel error in system call accept() under kernel 2.6.8
References: <43301BC4.9080305@wincor-nixdorf.com> <20050920150755.GH32751@kvack.org> <433028A3.9090503@wincor-nixdorf.com> <20050920152850.GI32751@kvack.org>
In-Reply-To: <20050920152850.GI32751@kvack.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben,


Right. But before Log.Log is called arguments of methods are
copied on the stack. That means, also the current content of
errno is copied. And "current" means in that case before the call
to Log.Log is performed (errno is transferred by value - not by
reference).

-Peter


Benjamin LaHaise wrote:

> On Tue, Sep 20, 2005 at 05:20:03PM +0200, Peter Duellings wrote:
> 
>>Hi Ben,
>>
>>if Log.Log would modify errno the Log.Log debug output should
>>not be affected since the value of errno - from my understanding -
>>is copied on the stack *before* Log.Log is called.
>>Or did I forget something?
> 
> 
> errno does not reside on the stack.
> 
> 		-ben


