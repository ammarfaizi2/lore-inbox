Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263783AbTETNuU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 09:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263789AbTETNuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 09:50:20 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:45047 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263783AbTETNtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 09:49:08 -0400
Message-ID: <3ECA3535.7090608@nortelnetworks.com>
Date: Tue, 20 May 2003 10:01:25 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Riley Williams <Riley@Williams.Name>
Cc: David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Recent changes to sysctl.h breaks glibc
References: <BKEGKPICNAKILKJKMHCAGECEDBAA.Riley@Williams.Name>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Riley Williams wrote:

> First, is there anything in include/asm that is actually needed
> outside the kernel itself? There shouldn't be, and if there is,
> it needs to be moved to a header under include/linux that is
> included in the relevant include/asm file.

It's handy for stuff like getting high res timestamps without having to ifdef 
the case of building on different architechtures.  Also, there are files under 
include/linux which end up including asm stuff in turn.

> The basic rule would be that external software can make free
> use of headers under include/linux but should never make any
> use whatsoever of headers under include/kernel or include/asm
> for any reason.

What if the include/linux files themselves make use of the asm files?

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

