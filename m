Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbWHHT7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbWHHT7b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 15:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbWHHT7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 15:59:31 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35221 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030279AbWHHT7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 15:59:30 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Magnus Damm <magnus@valinux.co.jp>, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org
Subject: Re: [PATCH] CONFIG_RELOCATABLE modpost fix
References: <20060808083307.391.45887.sendpatchset@cherry.local>
	<20060808183954.GA8300@mars.ravnborg.org>
Date: Tue, 08 Aug 2006 13:59:03 -0600
In-Reply-To: <20060808183954.GA8300@mars.ravnborg.org> (Sam Ravnborg's message
	of "Tue, 8 Aug 2006 20:39:54 +0200")
Message-ID: <m17j1j6ltk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:

> On Tue, Aug 08, 2006 at 05:32:11PM +0900, Magnus Damm wrote:
>> CONFIG_RELOCATABLE modpost fix
>> 
>> Run modpost on vmlinux regardless of CONFIG_MODULES.
> Below is my take on this one.
> - Dropped -rR since this is default now
> - Dropped subdir- assignment in scripts/Makefile since it is redundant
> - Always pass vmlinux ti modpost so we have full updated info
> - Print out number of modules being mod posted to distingush from
>   vmlinux one
> - use vmlinux as target name to enable nicer quiet command print

Sam, Magnus: 

I'm dense.  Why do we want to run modpost if we are building a kernel
that doesn't support modules?

I haven't mucked with modpost at all so I don't have a good feel for
what it does, or why we want to run it.

My quick skimming says modpost is all about generating the module
version symbol scrambling.  Which if that is all it does means it is
senseless to run this without modules.

Eric


