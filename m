Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUDPA6X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 20:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbUDPA6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 20:58:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52899 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261184AbUDPA6V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 20:58:21 -0400
Message-ID: <407F2F9C.4030702@pobox.com>
Date: Thu, 15 Apr 2004 20:58:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.26-rc2
References: <20040406004251.GA24918@logos.cnet> <4078E3BA.8040707@eyal.emu.id.au> <20040414121231.GA1406@logos.cnet> <407F1769.9090700@eyal.emu.id.au>
In-Reply-To: <407F1769.9090700@eyal.emu.id.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eyal Lebedinsky wrote:
> Marcelo Tosatti wrote:
> 
>> The void pointer case in here its being done math on without any 
>> problem. What is the
>> problem with void pointer math 
> 
> 
> There is a problem regarding the C standard. The semantics of 'void *' 
> are well defined
> and only allow for limited use. Basically, you can cast any pointer to 
> and from 'void *',
> but nothing else.
> 
> Pointer math says that 'p+n' means "add to 'p' the value 'n*s' where 's' 
> is the size
> on the element that 'p' points to". A 'void *' does not have a defined 
> element size
> until it is cast. So, ANSI specifically does not allow any arithmetics 
> on 'void *'.
> 
> Some compilers are forgiving and will invent an element size of '1' and 
> allow the
> math. We should not rely on such improper usage.


Void pointer arithmatic is an explicit gcc extension, and used 
extensively throughout the kernel.

	Jeff



