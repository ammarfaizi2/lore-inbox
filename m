Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270794AbUJUSaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270794AbUJUSaR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 14:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270797AbUJUSZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 14:25:58 -0400
Received: from chaos.analogic.com ([204.178.40.224]:11904 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S270692AbUJUSVm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 14:21:42 -0400
Date: Thu, 21 Oct 2004 14:21:25 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Sam Ravnborg <sam@ravnborg.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Module compilation
In-Reply-To: <20041021201545.GA16474@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0410211415560.14971@chaos.analogic.com>
References: <Pine.LNX.4.61.0410201034590.12062@chaos.analogic.com>
 <20041021201545.GA16474@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2004, Sam Ravnborg wrote:

> On Wed, Oct 20, 2004 at 10:36:00AM -0400, Richard B. Johnson wrote>
>> ...but it's not CFLAGS that needs to be modified, it's
>> a named variable that doesn't exist yet, perhaps "USERDEF",
>> or "DEFINES".
>
> Reading the above I cannot what amkes you say that EXTRA_CFLAGS
> or CFLAGS_module.o cannot be used?
> Is it the name you do not like or is it some fnctionality
> you are missing?
>

The name is wrong! There are zillions of ways to obtain the
functionality. Currently we need to piggy-back definitions
onto compiler flags.

Compiler flags are things like "-Wall" and "-O2", that tell
the compiler what to do. We need a name to use for definitions,
"-Dxxx", that #define constants (dynamically at compile-time)
in the code. Right now, -DMODULE and -D__KERNEL__ are piggybacked
onto CFLAGS. There really should be a variable called something
else like DEFINES and it should be exported.

>> I see that the normal "defines" is a constant
>> called "CHECKFLAGS", so this isn't appropriate for user
>> modification.
> CHECKFLAGS is only used when you use "make C=1" - to pass options
> to sparse.
>
> 	Sam
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 GrumpyMips).
                  98.36% of all statistics are fiction.
