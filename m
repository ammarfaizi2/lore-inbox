Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265445AbTFMRMK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 13:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265404AbTFMRMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 13:12:06 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:61660 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S265445AbTFMRLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 13:11:08 -0400
Message-ID: <3EEA071C.2090805@nortelnetworks.com>
Date: Fri, 13 Jun 2003 13:17:16 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Steven Dake <sdake@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
References: <3EE8D038.7090600@mvista.com> <20030612214753.GA1087@kroah.com> <3EE9F2E5.1050407@mvista.com> <20030613164216.GB5799@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Jun 13, 2003 at 08:51:01AM -0700, Steven Dake wrote:

>>The reality though, is that the user will be running the daemon to clear 
>>out the events.  If they don't, then they get what they deserve :)
>>
> 
> Heh, then your kernel which _has_ to stay up (due to your previous
> guarantees of uptime) keels over.  I don't think that by requiring that
> a kernel _has_ to have a specific userspace program running in order for
> it to stay healthy would be anying any "carrier grade" user would ever
> agree to.
> 
> :)

I don't think I totally buy that argument.  Often a "carrier-grade" box has a 
whole bunch of things that must be running for the box to stay healthy.  If one 
of them dies, the system logs the problem along with diagnostic information and 
tries to restart it.  If it can't be restarted, then we failover to the warm 
standby and go for a reboot to try and clean things up.

I agree that there are other issues, but needing to have a particular binary 
running isn't really a problem. (init, for example...)


Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

