Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262146AbVC2C3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbVC2C3N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 21:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbVC2C3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 21:29:13 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:47539 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262146AbVC2C3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 21:29:11 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Chris Wedgwood <cw@f00f.org>
Cc: Chris Wright <chrisw@osdl.org>, Coywolf Qi Hunt <coywolf@gmail.com>,
       Ali Akcaagac <aliakc@web.de>, linux-kernel@vger.kernel.org
Subject: Re: Kernel OOOPS in 2.6.11.6 
In-reply-to: Your message of "Mon, 28 Mar 2005 18:06:08 PST."
             <20050329020608.GA4675@taniwha.stupidest.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 29 Mar 2005 12:27:01 +1000
Message-ID: <7326.1112063221@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2005 18:06:08 -0800, 
Chris Wedgwood <cw@f00f.org> wrote:
>On Mon, Mar 28, 2005 at 04:24:15PM -0800, Chris Wright wrote:
>
>> Imperfect stack trace decoding.
>
>Is this with CONFIG_4K_STACKS?  does it happen w/o it?

i386 needs unwind data plus a kernel unwinder to get accurate
backtraces.  Without the data and an unwinder, i386 backtraces are best
guess.  They often contain spurious addresses, from noise words that
were left on the kernel stack.  Nothing to do with CONFIG_4K_STACKS.

