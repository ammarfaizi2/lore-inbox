Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277410AbRJJV2c>; Wed, 10 Oct 2001 17:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277412AbRJJV2W>; Wed, 10 Oct 2001 17:28:22 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:14084 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S277410AbRJJV2S>;
	Wed, 10 Oct 2001 17:28:18 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Morgan Collins [Ax0n]" <sirmorcant@morcant.org>
Cc: tkhoadfdsaf@hotmail.com, dwmw2@infradead.org, alan@lxorguk.ukuu.org.uk,
        viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: Tainted Modules Help Notices 
In-Reply-To: Your message of "Wed, 10 Oct 2001 13:28:21 MST."
             <34710.24.255.76.12.1002745701.squirrel@webmail.morcant.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Oct 2001 07:28:36 +1000
Message-ID: <16172.1002749316@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2001 13:28:21 -0700 (PDT), 
"Morgan Collins [Ax0n]" <sirmorcant@morcant.org> wrote:
>I think that the modprobe source and the kernel source just aren't in sync with the
>development of the new (re DEVELOPMENTAL) MOD_LICENSE() implementation.

What makes you say that?  The list of GPL compatible license strings is
in include/linux/module.h, modutils uses *exactly* the same set of
strings.  If somebody uses a different string, their license is not
GPL.

>If the purpose was to discriminate against licensing, I would agree. But since
>non-compatible source is not distributed with the kernel, and the mechanism is for
>debugging, what is the purpose of lying to the kernel? To confuse debuggers? No point in that.

To triage bug reports.  Any bug report against a tainted kernel is
almost certain to be bounced with "your kernel contains code that we do
not have the source for, send this bug report to the company that
maintains the non-GPL code".

>>     Just out of curiosity do all of these license tags in the modules take
>> up any permanent kernel memory, especially in a heavily modularize system?
>> 

No, they are in the modinfo section along with module parms, author,
description, kernel vesrion etc.  None of that gets loaded into memory.

