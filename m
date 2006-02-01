Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbWBAC4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbWBAC4J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 21:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbWBAC4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 21:56:09 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:26044 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1030259AbWBAC4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 21:56:08 -0500
Message-ID: <43E02340.2020406@tlinx.org>
Date: Tue, 31 Jan 2006 18:56:00 -0800
From: "L. A. Walsh" <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: i386 requires x86_64?
References: <43DED532.5060407@tlinx.org>	 <20060130193129.19f04e6f.rdunlap@xenotime.net> <1138712535.7088.5.camel@localhost.localdomain>
In-Reply-To: <1138712535.7088.5.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Mon, 2006-01-30 at 19:31 -0800, Randy.Dunlap wrote:
>   
>> Yes, there are bits in i386 that use x86_64 and there are
>> bits in x86_64 that use i386 code, so that the source code
>> won't have to be duplicated.
>>     
> Perhaps we need an arch/x86_common that has this code.  Not just to help
> those that like to delete other archs, but also to make it easier for us
> that might modify the code and know that this code is shared.  It's
> better design to have a arch/x86_common that is compiled with i386 and
> x86_64 than to have code with - #include "../../x86_64/kernel/blah.c" -
> in it.
>
>   
I'd tend to agree (unless it is a big problem).
It seems an unsound design principle to manually be
including code via direct references to a different architecture
tree.

Linda

