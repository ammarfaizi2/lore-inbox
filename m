Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbVLGG25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbVLGG25 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 01:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbVLGG25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 01:28:57 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:41112 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932463AbVLGG25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 01:28:57 -0500
Message-ID: <439681CF.90305@in.ibm.com>
Date: Wed, 07 Dec 2005 12:01:43 +0530
From: Sachin Sant <sachinp@in.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] Adding ctrl-o sysrq hack support to 8250 driver
References: <438D8A3A.9030400@in.ibm.com> <20051130130429.GB25032@flint.arm.linux.org.uk> <43953440.9070102@in.ibm.com> <20051206171633.GB19664@flint.arm.linux.org.uk>
In-Reply-To: <20051206171633.GB19664@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>Frown.  Sorry, I'm not sure what "p615", "power4" and "no-hmc" is.  I
>also don't know what an IBM 3153 is.
>
>However, you seem to be suggesting that a terminal application somehow
>forwards the ctrl-sysrq (and it's actually alt-sysrq).  Maybe it does,
>maybe it doesn't.  Probably depends on the terminal application itself.
>
>Eg, with minicom, you need to ask minicom to create the serial break
>event itself, normally by (assuming default configuration) <ctrl-a> <f>.
>
>  
>
Sorry about using all those cryptic terms. I was trying to explain with
the help of few test scenario's. I had tested on couple of PowerPC processor
based machines which can be configured either as a standalone machine 
[ Without any Logical Partitions ] or can be logically partitioned.
One can use a Hardware Management console [HMC] to manage the machine.


>I don't think you've addressed my concern... but I'm afraid I haven't
>been able to properly follow what you're saying.
>
>In any case, applying this patch means that you _permanently_ prevent
>the reception of ^O on _ANY_ 8250 serial port, whether it be a serial
>console or not.
>
>With this patch, I guess it's tough luck if you have a modem connected
>to your PC and you want to run ppp or x,y,z modem protocols.
>
>  
>
The point i was trying to make was to have a consistent behavior across
virtual and real consoles connected to certain kind of machines. 
But as stated by you this patch might cause lot of inconvenience to 
other user. So it's best not to introduce this patch.

>  
>

