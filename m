Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbUCLUSK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 15:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262502AbUCLUQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 15:16:53 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:38858 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262454AbUCLULg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 15:11:36 -0500
Message-ID: <4052196E.3010304@nortelnetworks.com>
Date: Fri, 12 Mar 2004 15:11:26 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sting sting <zstingx@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: do_brk() trace  mystery
References: <Sea2-F60clKZMX3rQvx00046766@hotmail.com>
In-Reply-To: <Sea2-F60clKZMX3rQvx00046766@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sting sting wrote:

> But I did a search on the kernel tree fo do_brk()
> and I found only 5 entries (in 2.6 kernel and also in 2.4.24).
> One of the was the declaration in mm.h; the other was
> implementation in mmap.c

You probably want sys_brk().

> So the mystery is : who calls the brk() system call when I type
> "cat /proc/interrupts"

cat calls malloc(), glibc calls brk(), kernel does sys_brk()

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
