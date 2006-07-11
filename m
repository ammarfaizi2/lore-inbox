Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWGKT3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWGKT3J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWGKT3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:29:09 -0400
Received: from terminus.zytor.com ([192.83.249.54]:41647 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751199AbWGKT3I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:29:08 -0400
Message-ID: <44B3EDBA.4090109@zytor.com>
Date: Tue, 11 Jul 2006 11:28:10 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Cedric Le Goater <clg@fr.ibm.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 0/7] execns syscall and user namespace
References: <20060711075051.382004000@localhost.localdomain> <44B3EA16.1090208@zytor.com> <44B3ED3B.3010401@fr.ibm.com>
In-Reply-To: <44B3ED3B.3010401@fr.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric Le Goater wrote:
> H. Peter Anvin wrote:
> 
>> I would like give a strong objection to the naming.  The -ve() suffix in
>> execve() isn't jettisonable; it indicates its position within a family
>> of functions (only one of which is a true system call.)
>>
>> execven() would be better name (the -n argument coming after then -e
>> argument).  The library could then provide execlen(), execlpn() etc as
>> appropriate.
> 
> I agree. execns() is a shortcut.
> 
> This service behaves like execve() if the flag argument is 0, so I guess we
> should keep the execve- prefix. However, we could be a bit more explicit on
> the nature of this service and call it execve_unshare().
> 

How about execveu()?  -n looked a bit weird to me, mostly because the 
"le" form would be execlen() which looks like something completely 
different...

	-hpa
