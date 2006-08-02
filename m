Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWHBT2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWHBT2g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 15:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWHBT2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 15:28:36 -0400
Received: from mail.aknet.ru ([82.179.72.26]:10771 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S932158AbWHBT2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 15:28:35 -0400
Message-ID: <44D0FD92.9010202@aknet.ru>
Date: Wed, 02 Aug 2006 23:31:30 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Zachary Amsden <zach@vmware.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: + espfix-code-cleanup.patch added to -mm tree
References: <200608021515_MC3-1-C6D7-2B90@compuserve.com>
In-Reply-To: <200608021515_MC3-1-C6D7-2B90@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Chuck Ebbert wrote:
> Only problem I have with this is we lose the original fault info from
> the iret.  So we have no real way of knowing whether it was #GP, #NP, #SF
> or whatever, and no record of the offending iret's address.
Thanks for the precise explanation.
There was also a problem with me reading the Intel's manual:
it uses Pop() in their pseudo-code, and it Pop()'s the values
*before* checking them. The description of the Pop() is very
confusing:
---
Pop() removes the value from the top of the stack and returns it.
---
What "removes" means here is unclear. Whether it adjusts a stack
pointer, is unclear. Since it is Pop(), I was assuming "removes"
means it also adjusts the stack pointer, but now I see it was a
wrong guess.

