Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268260AbTGLSte (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 14:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268281AbTGLStd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 14:49:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2188 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268260AbTGLStc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 14:49:32 -0400
Message-ID: <3F105B9A.7070803@pobox.com>
Date: Sat, 12 Jul 2003 15:03:54 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Andrew Morton <akpm@osdl.org>, davej@codemonkey.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5 'what to expect'
References: <20030711140219.GB16433@suse.de> <20030712152406.GA9521@mail.jlokier.co.uk> <3F103018.6020008@pobox.com> <20030712112722.55f80b60.akpm@osdl.org> <20030712183929.GA10450@mail.jlokier.co.uk>
In-Reply-To: <20030712183929.GA10450@mail.jlokier.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Andrew Morton wrote:
> 
>>>One problem is O_DIRECT should return an error on open(2) or fcntl(2), 
>>> not write(2).
>>
>>That is the 2.5 behaviour.
> 
> 
> What do you mean?
> 
> The problem with db4 is that operations on O_DIRECT handles now return
> EINVAL if the address isn't suitable aligned, and db4 is not expecting
> that - it aborts.  That was true for 2.5.74, at least.


These are separate db4+kernel problems.

The first is that there needs to be a reliable way to know if O_DIRECT 
writes are going to succeed or not.  The 2.4 kernel fails on write(2) 
but not open(2) or fcntl(2).

The second is that db4 doesn't appear to know about the alignment 
requirement.

	Jeff



