Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVFNXGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVFNXGp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 19:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbVFNXGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 19:06:45 -0400
Received: from smtpout1.bayarea.net ([209.128.95.10]:26803 "EHLO
	smtpout1.bayarea.net") by vger.kernel.org with ESMTP
	id S261402AbVFNXGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 19:06:35 -0400
Message-ID: <42AF62CF.9000501@bayarea.net>
Date: Wed, 15 Jun 2005 00:05:51 +0100
From: Robert Gadsdon <rgadsdon@bayarea.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050415
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] optimization for sys_semtimedop() (was: Opening Day for
 OpenSolaris)
References: <fa.gjr3si0.110j3e@ifi.uio.no>
In-Reply-To: <fa.gjr3si0.110j3e@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IANAL, but if this is from 'OpenSolaris sources' then surely it would be 
incompatible with the GPL?

Robert Gadsdon.

Manfred Spraul wrote:
> Hi,
> 
> semtimedop() performs a semaphore operation and if the operation cannot 
> be performed immediately, then the function blocks until the timeout 
> expires.
> The current Linux implementation loads the timeout immediately, even if 
> the operation doesn't block.
> As explained in the OpenSolaris sources, this is not needed. The 
> attached patch changes the Linux code.
> 
> The patch is trivial, but not tested. It shrinks the .text size by 32 
> bytes on x86.
> 
> -- 
>    Manfred
> 
