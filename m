Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263918AbTGFWMF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 18:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbTGFWMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 18:12:05 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:504 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263918AbTGFWMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 18:12:03 -0400
Subject: Re: C99 types VS Linus types
From: Albert Cahalan <albert@users.sf.net>
To: bernie@develer.com, vojtech@suse.cz,
       linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1057529906.749.41.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 Jul 2003 18:18:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik writes:
> On Sun, Jul 06, 2003 at 07:37:26PM +0200, Bernardo Innocenti wrote:
>> On Sunday 06 July 2003 14:23, Philippe Elie wrote:

>>> alpha user space .h define uint64_t as unsigned long,
>>> include/asm-alpha/types.h defines it as unsigned long long.
>>
>> Why is that? Isn't uint64_t supposed to be _always_ a 64bit
>> unsigned integer? Either the kernel or the user space might
>> be doing the wrong thing...
>>
>>  I've Cc'd the Alpha mantainer to make him aware of this
>> problem.
>
> I suppose both an 'unsigned long' and 'unsigned long long'
> are 64-bit entities on the Alpha (which is a 64-bit
> architecture).

Sure, both are "correct", but there would be a lot less
pain and suffering in the world if "unsigned long long"
would be used for 64-bit. It ought to be at least 40 years
before 128-bit types begin to matter. In the Linux world,
we can consider "long long" to be 64-bit, "int" to be
32-bit, and "long" to be the same size as a pointer.

Then we can ditch the nasty casts:
sprintf(foo, "%llu", (unsigned long long)bar);

This leaves only Win64, Win16, DOS, and ELKS out in
the cold. Like we should care for kernel & glibc!


