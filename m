Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262736AbVBYPyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbVBYPyY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 10:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbVBYPyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 10:54:24 -0500
Received: from [195.23.16.24] ([195.23.16.24]:9431 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262739AbVBYPyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 10:54:05 -0500
Message-ID: <421F49E0.9090806@grupopie.com>
Date: Fri, 25 Feb 2005 15:53:04 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Oeser <ioe-lkml@axxeo.de>
Cc: Chris Friesen <cfriesen@nortel.com>, "Chad N. Tindel" <chad@tindel.net>,
       Mike Galbraith <EFAULT@gmx.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Xterm Hangs - Possible scheduler defect?
References: <20050224075756.GA18639@calma.pair.com> <200502250151.41793.ioe-lkml@axxeo.de> <421F4042.3020302@nortel.com> <200502251639.50238.ioe-lkml@axxeo.de>
In-Reply-To: <200502251639.50238.ioe-lkml@axxeo.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> Chris Friesen wrote:
> 
>>Ingo Oeser wrote:
>>[...]
> You would need to change the priority of task 1 until it releases the
> mutex. Ideally the owner gets the maximum priority of
> his and all the waiters on it, until it releases his mutex, where he regains
> its old priority after release of mutex. But this priority elevation happens
> only, if he is runnable. If not, he gets his old priority back, until he is 
> runnable.

This is called a "priority inversion" problem, and there was some work 
done by Ingo Molnar to make the scheduler aware of such cases and handle 
them appropriatelly.

You can follow this thread for more info:

http://marc.theaimsgroup.com/?l=linux-kernel&m=110106915415886&w=2

I really don't know what's the current state, but this is nothing new...

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
