Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266948AbSKWCg0>; Fri, 22 Nov 2002 21:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266958AbSKWCg0>; Fri, 22 Nov 2002 21:36:26 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:29710 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S266948AbSKWCgZ>;
	Fri, 22 Nov 2002 21:36:25 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: New module loader makes kernel debugging much harder 
In-reply-to: Your message of "Sat, 23 Nov 2002 02:35:13 -0000."
             <20021123023513.GC83190@compsoc.man.ac.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 23 Nov 2002 13:43:20 +1100
Message-ID: <13864.1038019400@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Nov 2002 02:35:13 +0000, 
John Levon <levon@movementarian.org> wrote:
>On Sat, Nov 23, 2002 at 01:20:10PM +1100, Keith Owens wrote:
>
>> The complete lack of kernel and module symbols (no /proc/ksyms) means
>> that ksymoops is now useless on 2.5 kernels.  If you get an oops in a
>> kernel built without kksymoops, there is no way to decode the oops.
>
>Additionally, module profiling is not possible any more.
>
>> Big step backwards, Rusty.
>
>Somebody (this includes Rusty himself) needs to come up with a workable
>solution. For my own needs, the start address of the mapped module is
>good enough [snip]

Only if you assume that the .text is at a known offset from the start
of the module.  There are multiple programs that need to know where
each section really is, instead of making assumptions about how a
module is laid out.

