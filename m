Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266655AbUAWTQZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 14:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266656AbUAWTQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 14:16:25 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:29145 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S266655AbUAWTQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 14:16:20 -0500
Message-ID: <401172D8.8040507@nortelnetworks.com>
Date: Fri, 23 Jan 2004 14:15:36 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
Cc: Mariusz Mazur <mmazur@kernel.pl>, linux-kernel@vger.kernel.org,
       debian-glibc@lists.debian.org
Subject: Re: Userland headers available
References: <200401231907.17802.mmazur@kernel.pl> <20040123184755.GA2138@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz wrote:

 > I would really like to come up with an approach to maintain this 
interface
 > definition in the kernel source.  I'm still trying to think of a
 > way to do it without breaking compatibility or kernel builds.

The obvious way is to have the kernel headers include the userland
headers, then everything below that be wrapped in "#ifdef __KERNEL__". 
Userland then includes the normal kernel headers, but only gets the 
userland-safe ones.

This sounds too easy though--I'm sure I've missed something, but I can't 
think what....

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

