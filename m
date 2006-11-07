Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754156AbWKGQNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156AbWKGQNM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 11:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754164AbWKGQNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 11:13:12 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:48838 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1754156AbWKGQNK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 11:13:10 -0500
Message-ID: <4550B088.9040900@fr.ibm.com>
Date: Tue, 07 Nov 2006 17:12:56 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add-process_session-helper-routine-deprecate-old-field-tidy
References: <20061024183658.GA1905@oleg>
In-Reply-To: <20061024183658.GA1905@oleg>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> Cedric Le Goater wrote:
>> -	.session	= 1,						\
>> +	.tty_old_pgrp   = 0,						\
>> +	{ .session      = 1},						\
> 
> Any reason to initialize .tty_old_pgrp explicitly? This gives a false
> positive from grep...

it helps some version of gcc to find the anonymous union. I need to dig
this issue a little bit more.

thanks,

C.   
