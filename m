Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbULWReU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbULWReU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 12:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbULWReU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 12:34:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:63890 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261274AbULWReR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 12:34:17 -0500
Message-ID: <41CB0064.4030606@osdl.org>
Date: Thu, 23 Dec 2004 09:29:08 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Umar Draz <kernel_org@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: What is This?????
References: <BAY16-F28BA5CE1494903C6393DD2F1A50@phx.gbl>
In-Reply-To: <BAY16-F28BA5CE1494903C6393DD2F1A50@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Umar Draz wrote:
> Hi Dear Members!!
> 
>  on debian i want to compile kernel 2.4.28 then i use make modules this 
> kind lines i saw
> 
> applicom.c:544: warning: unknown conversion type character `z' in format
> 
> what is this is it some thing wrong?
> 
> waiting for response

Is your gcc version 2.95 or so?

Just edit applicom.c and change all "%zd" to "%Zd"
and gcc will be happy.  Small "z" is ANSI C,
but gcc 2.95 only knows about large "Z".
Later gcc knows about both.

-- 
~Randy
