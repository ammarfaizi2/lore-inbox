Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266675AbUAWTkq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 14:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbUAWTkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 14:40:46 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:53428 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S266675AbUAWTki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 14:40:38 -0500
Message-ID: <4011788D.3070606@nortelnetworks.com>
Date: Fri, 23 Jan 2004 14:39:57 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
Cc: Mariusz Mazur <mmazur@kernel.pl>, linux-kernel@vger.kernel.org,
       debian-glibc@lists.debian.org
Subject: Re: Userland headers available
References: <200401231907.17802.mmazur@kernel.pl> <20040123184755.GA2138@nevyn.them.org> <401172D8.8040507@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Friesen, Christopher [CAR:7Q28:EXCH] wrote:

> The obvious way is to have the kernel headers include the userland
> headers, then everything below that be wrapped in "#ifdef __KERNEL__". 
> Userland then includes the normal kernel headers, but only gets the 
> userland-safe ones.

I just realized this wasn't clear.  I envision a new set of headers in 
the kernel that are clean to export to userland.  The current headers 
then include the appropriate userland-clean ones, and everything below 
that is kernel only.

This lets the kernel maintain the userland-clean headers explicitly, and 
we don't have the work of cleaning them up for glibc.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

