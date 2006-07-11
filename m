Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWGKSNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWGKSNM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbWGKSNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:13:12 -0400
Received: from terminus.zytor.com ([192.83.249.54]:41115 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932069AbWGKSNK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:13:10 -0400
Message-ID: <44B3EA16.1090208@zytor.com>
Date: Tue, 11 Jul 2006 11:12:38 -0700
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
References: <20060711075051.382004000@localhost.localdomain>
In-Reply-To: <20060711075051.382004000@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric Le Goater wrote:
> Hello !
> 
> The following patchset adds the user namespace and a new syscall execns.
> 
> The user namespace will allow a process to unshare its user_struct table,
> resetting at the same time its own user_struct and all the associated
> accounting.
> 
> The purpose of execns is to make sure that a process unsharing a namespace
> is free from any reference in the previous namespace. the execve() semantic
> seems to be the best candidate as it already flushes the previous process
> context.
> 
> Thanks for reviewing, sharing, flaming !
> 

I would like give a strong objection to the naming.  The -ve() suffix in 
execve() isn't jettisonable; it indicates its position within a family 
of functions (only one of which is a true system call.)

execven() would be better name (the -n argument coming after then -e 
argument).  The library could then provide execlen(), execlpn() etc as 
appropriate.

	-hpa
