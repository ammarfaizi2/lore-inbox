Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265463AbTFMRyx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 13:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265464AbTFMRyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 13:54:53 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24078 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S265463AbTFMRxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 13:53:34 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Date: Fri, 13 Jun 2003 18:06:43 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <bcd3rj$1it$1@old-penguin.transmeta.com>
References: <3EE8D038.7090600@mvista.com>
X-Trace: palladium.transmeta.com 1055527603 18993 127.0.0.1 (13 Jun 2003 18:06:43 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 13 Jun 2003 18:06:43 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@old-penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3EE8D038.7090600@mvista.com>,
Steven Dake  <sdake@mvista.com> wrote:
>
>I have been looking at the udev idea that Greg KH has developed.  
>Userland device enumeration definately is the way to go, however, there 
>are some problems with using /sbin/hotplug to transmit device 
>enumeration events:

No.

WE ARE NOT GOING TO A EVENT DEAMON!

Centralized event deamons are crap, unmaintainable, and unreadable. 
They are a maintenance nightmare, both from a development standpoint and
from a MIS standpoint.  They encourage doing everything in one program,
keeping state in private memory, depending on ordering, and just
generally do bad things. 

/sbin/hotplug, on the other hand, makes events clearly independent
things, and encourages writing simple scripts that can be combined and
localized. In other words, it's the UNIX way.

I've seen the madness of event deamons, and it's called "cardmgr" and
"acpid". We don't want it. 

			Linus
