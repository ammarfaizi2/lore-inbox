Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262357AbVC3RYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbVC3RYq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 12:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbVC3RYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 12:24:46 -0500
Received: from smtp4.poczta.onet.pl ([213.180.130.28]:26273 "EHLO
	smtp4.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S262357AbVC3RYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 12:24:44 -0500
Message-ID: <424AE18B.1080009@poczta.onet.pl>
Date: Wed, 30 Mar 2005 19:27:39 +0200
From: Wiktor <victorjan@poczta.onet.pl>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFD] 'nice' attribute for executable files
References: <fa.ed33rit.1e148rh@ifi.uio.no> <E1DGNaV-0005LG-9m@be1.7eggert.dyndns.org> <424ACEA9.6070401@poczta.onet.pl> <yw1xpsxhvzsz.fsf@ford.inprovide.com>
In-Reply-To: <yw1xpsxhvzsz.fsf@ford.inprovide.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:
> 
> It can be done entirely in userspace, if you want it.  Just hack your
> shell to examine some extended attribute of your choice, and adjust
> the nice value before executing files.  Then arrange to have the shell
> run with a negative nice value.  This can be easily accomplished with
> a simple wrapper, only for the shell.
> 

this method can be applied, as you've written, only for shell (which 
have to be hacked before). so, every program that runs any other program 
should be hacked to use pre-execution-renice-database. rewriting all the 
programs in the world takes a bit more time than i have to the death. 
woudn't it be simplier to implement it in kernel, somewhere near 
setuid/setgid bits? if it would make system slower, support of such 
attribute could be optional, just like acl-s.
i've found a way to perform such function in userland, but it is awful, 
and, if some program runs another, that should be reniced, very often, 
starting a shell (even ash) for each call will surely smoke my cpu.
this feature without doubt belongs to kernel - it is performed every 
time kernel starts a program, and it is not so complicated like, let's 
say, hotplug support, is it?

thx for replies

--
wixor
Maye the Source be with you.
