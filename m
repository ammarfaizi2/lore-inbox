Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVCOW5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVCOW5C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 17:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVCOWy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 17:54:26 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:19282 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S262053AbVCOWwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 17:52:51 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="3.90,166,1107763200"; 
   d="scan'208"; a="619714124:sNHT20807384"
Message-Id: <5.1.0.14.2.20050315232212.05f5d4c8@171.71.163.14>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 15 Mar 2005 23:35:34 +1100
To: comsatcat <comsatcat@earthlink.net>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: qla2xxx fail over support
Cc: Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <1110919432.11160.6.camel@solaris.zataoh.com>
References: <20050314231630.GB8548@plap.qlogic.org>
 <1110838136.12171.4.camel@solaris.zataoh.com>
 <20050314231630.GB8548@plap.qlogic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:43 AM 16/03/2005, comsatcat wrote:
>Unfortunantly all the beta drivers seem to have issues working with
>mcdata switches.  I've tried about 10 different versions available from
>qlogic's ftp and all of them give trace messages and "scheduling while
>atomic" messages when detecting luns that are going through the mcdata
>switch.  any suggestions would be appreciated (along with whom to
>contact at qlogic regarding beta driver development).

use a Cisco MDS FC switch and all your problems will go away. :-)
just kidding ... the errors you're seeing will likely happen regardless of 
what brand FC switch you have .. LUN Discovery and/or FC NS queries are 
likely the same regardless of FC switch.

what you're seeing is essentially a bug in the qlogic driver - and likely 
why it was listed as being "beta".

if you're after multipathing support, rather than doing it in the FC 
driver, may i suggest that you instead look at using Christophe Varoqui's 
excellent multipath-tools (see 
http://christophe.varoqui.free.fr/wiki/wakka.php?wiki=Home) which i have 
used successfully here across a range of midrange & enterprise storage arrays


cheers,

lincoln.
