Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbTDQW6y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 18:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbTDQW6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 18:58:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26025 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262663AbTDQW6w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 18:58:52 -0400
Message-ID: <3E9F346C.8070406@pobox.com>
Date: Thu, 17 Apr 2003 19:10:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Arjan van de Ven <arjanv@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BK+PATCH] remove __constant_memcpy
References: <1050569207.1412.1.camel@laptop.fenrus.com> <Pine.LNX.4.44.0304170903001.1530-100000@home.transmeta.com> <20030417191939.GG25696@gtf.org> <20030417225850.GA17476@werewolf.able.es>
In-Reply-To: <20030417225850.GA17476@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> On 04.17, Jeff Garzik wrote:
> 
>>On Thu, Apr 17, 2003 at 09:07:45AM -0700, Linus Torvalds wrote:
> 
> [...]
> 
>>	#define memcpy(t, f, n) \
>>	(__builtin_constant_p(n) ? \
>>	 __constant_memcpy3d((t),(f),(n)) : \
>>	 __memcpy3d((t),(f),(n)))
>>
> 
> 
> Do you know if this is more efficient ? :
> 
> __builtin_choose_expr(__builtin_constant_p(n), ... , ....)
> 
> Perhaps ?: reaches runtime, and __builtin doesn't.


No.  The existing code (quoted above) is properly evaluated at 
compile-time...

	Jeff



