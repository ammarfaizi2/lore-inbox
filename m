Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbTILOcT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 10:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbTILOcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 10:32:18 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:12432 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261644AbTILOcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 10:32:15 -0400
Message-ID: <3F61D8E4.6020309@nortelnetworks.com>
Date: Fri, 12 Sep 2003 10:32:04 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: firewalling PPPOE stream without terminating it
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've got a PPPOE DSL line coming into my house, and I and my roommates 
each terminate our own connection and get our own dynamic IP address.

With the recent bunch of viruses/worms, a couple of us were thinking 
about setting up a box as a transparent firewalling bridge.  The only 
tricky bit is that we don't want to terminate the PPPOE connection at 
that box, since that would then force us to do NAT/ipmasq.

Does anyone know of any way to filter the contents of a tunnelled packet 
(PPPOE in particular) using standard tools like ebtables/iptables?

The other possibility I had considered was a netfilter module that tied 
into the ebtables hooks and knew how to look inside the PPPOE packet, 
but then I wouldn't get the userspace interface from ebtables/iptables.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

