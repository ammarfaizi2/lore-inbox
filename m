Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262037AbTCQXbC>; Mon, 17 Mar 2003 18:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262043AbTCQXbC>; Mon, 17 Mar 2003 18:31:02 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:11274 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262037AbTCQXbB>;
	Mon, 17 Mar 2003 18:31:01 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.21-pre5 kksymoops for i386/ia64 
In-reply-to: Your message of "Mon, 17 Mar 2003 17:33:07 BST."
             <m3wuiyx8ak.fsf@averell.firstfloor.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 18 Mar 2003 10:41:46 +1100
Message-ID: <30411.1047944506@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Mar 2003 17:33:07 +0100, 
Andi Kleen <ak@muc.de> wrote:
>Keith Owens <kaos@ocs.com.au> writes:
>
>> Automatic decoding of oops on 2.5 has been very useful, so this patch
>> adds kksymoops support to 2.4.21-pre5.  Currently only for i386 and
>> ia64, other architectures are easy to add.
>
>This 2.4 kallsyms patch doesn't work for cross compilation because
>the modutils are terminally broken in this regard.
>
>Rather than using this patch I would rather backport the 2.5 code
>which works fine even for cross and compresses the symbol tables too.

The 2.5 kallsyms does not have section data which is required for kdb
(and probably kgdb).  That data used to be there until Rusty deleted
it, the lack of section data is one of the reasons that I no longer do
kdb for 2.5.  If you want to kill kdb for 2.4 kernels as well, go ahead
and backport the incomplete 2.5 code.

