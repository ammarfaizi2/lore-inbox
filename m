Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbTLIDtp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 22:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbTLIDtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 22:49:45 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:50305 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262731AbTLIDto
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 22:49:44 -0500
Date: Tue, 9 Dec 2003 03:49:35 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Nikita Danilov <Nikita@Namesys.COM>, Arnd Bergmann <arnd@arndb.de>,
       linux-kernel@vger.kernel.org
Subject: Re: const versus __attribute__((const))
Message-ID: <20031209034935.GA26987@mail.shareable.org>
References: <200312081646.42191.arnd@arndb.de> <3FD4B9E6.9090902@zytor.com> <16340.49791.585097.389128@laputa.namesys.com> <3FD4C375.2060803@zytor.com> <20031209025952.GA26439@mail.shareable.org> <3FD53FC6.5080103@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD53FC6.5080103@zytor.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> > It would be nice to have a way to declare an asm like "pure" not
> > "const", so that it's allowed to read memory but multiple calls can be
> > eliminated; I don't know of a way to express that.
> 
> Just specify memory input operands.

Thanks.  That's even more useful than "pure" because it implies the
asm only reads the explicitly passed memory operands.

Memory input operands don't work if you want the asm to read arbitrary
memory not mentioned in the inputs (like "pure" allows) or traverse
linked lists.

(A long time ago there was a question about whether GCC could ever
copy the value associated with an "m" operand to a stack slot, and
pass the address of the stack slot.  After all, GCC _will_ copy the
value if the operand is an "r", and presumably gives mixed results
with "rm".  We seem to have concluded that it never will).

-- Jamie
