Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262283AbULCUuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbULCUuV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 15:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbULCUuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 15:50:20 -0500
Received: from quark.didntduck.org ([69.55.226.66]:25220 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S262283AbULCUuK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 15:50:10 -0500
Message-ID: <41B0D18B.3020309@didntduck.org>
Date: Fri, 03 Dec 2004 15:50:19 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sylvain <autofr@gmail.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: distinguish kernel thread / user task
References: <64b1faec041203091654251b18@mail.gmail.com>	 <41B0BD6B.2010809@didntduck.org> <64b1faec0412031215b934a9@mail.gmail.com>
In-Reply-To: <64b1faec0412031215b934a9@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sylvain wrote:
> I am trying to do a tool to record task switching...separating also
> kernel/user tasks, but I got some trouble with that last case.
> 
> I confused since "ps" is actually able to distinguish kernel thread
> from user task.
> I wouldn't had a flag if It 's not necessary
> 
> Sylvain
> 

Pstools doesn't really know the difference between user and kernel 
threads.  It only shows kernel threads as swapped out (in brackets) 
because they have an RSS of zero (since kernel threads have no mm struct).

--
				Brian Gerst
