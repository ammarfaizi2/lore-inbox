Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbTFBO1Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 10:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbTFBO1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 10:27:24 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:4755 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262362AbTFBO1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 10:27:23 -0400
Message-ID: <3EDB61C8.3020504@nortelnetworks.com>
Date: Mon, 02 Jun 2003 10:40:08 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Andrew Morton <akpm@digeo.com>, Chris Wright <chris@wirex.com>,
       gj@pointblue.com.pl, Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>,
       Greg Kroah-Hartman <greg@kroah.com>
Subject: Re: [PATCH][LSM] Early init for security modules and various	cleanups
References: <20030602025450.C27233@figure1.int.wirex.com>	 <Pine.LNX.4.44.0306021205520.27640-100000@pointblue.com.pl>	 <20030602030946.H27233@figure1.int.wirex.com>	 <20030602034419.3776d3b7.akpm@digeo.com> <1054558223.1053.105.camel@moss-huskers.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley wrote:
> On Mon, 2003-06-02 at 06:44, Andrew Morton wrote:
> 
>>Chris Wright <chris@wirex.com> wrote:
>>
>>>security_capable() returns 0 if that capability bit is set. 
>>>
>>That's just bizarre.  Is there any logic behind it?
>>
> 
> The LSM access control hooks all return 0 on success (i.e. permission
> granted) and negative error code on failure, like most of the rest of
> the kernel interfaces (e.g. consider permission())

Maybe it should be called "security_incapable() and then the return code can be 
treated as a boolean true/false....


Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

