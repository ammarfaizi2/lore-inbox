Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUKHS2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUKHS2y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 13:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbUKHS1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 13:27:22 -0500
Received: from alog0232.analogic.com ([208.224.220.247]:5760 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261169AbUKHS01
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 13:26:27 -0500
Date: Mon, 8 Nov 2004 13:22:08 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Andi Kleen <ak@suse.de>
cc: Adrian Bunk <bunk@stusta.de>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] kill IN_STRING_C
In-Reply-To: <20041108161935.GC2456@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0411081308320.5968@chaos.analogic.com>
References: <20041107142445.GH14308@stusta.de> <20041108134448.GA2456@wotan.suse.de>
 <20041108153436.GB9783@stusta.de> <20041108161935.GC2456@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2004, Andi Kleen wrote:

>> Rethinking it, I don't even understand the sprintf example in your
>> changelog entry - shouldn't an inclusion of kernel.h always get it
>> right?
>
> Newer gcc rewrites sprintf(buf,"%s",str) to strcpy(buf,str) transparently.
>
> -Andi

Hmmm, how does it get the correct return-value and type? I don't
think that a compiler is allowed to change the function(s) called.
If gcc is doing this now, there are many potential problems and
it needs to be fixed. For instance, one can't qualify a
'C' runtime library and then have a compiler decide that it's
not going to call the pre-qualified function.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
