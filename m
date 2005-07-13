Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVGMRJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVGMRJX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVGMRGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:06:46 -0400
Received: from vhost12.digitarus.com ([84.234.16.61]:14743 "EHLO
	vhost12.digitarus.com") by vger.kernel.org with ESMTP
	id S261289AbVGMREy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:04:54 -0400
X-ClientAddr: 212.126.40.83
Message-ID: <42D549B4.1010406@wiggly.org>
Date: Wed, 13 Jul 2005 18:04:52 +0100
From: Nigel Rantor <wiggly@wiggly.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vinay Venkataraghavan <raghavanvinay@yahoo.com>
CC: linux-crypto@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Open source firewalls
References: <20050713163424.35416.qmail@web32110.mail.mud.yahoo.com>
In-Reply-To: <20050713163424.35416.qmail@web32110.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Digitarus-vhost12-MailScanner-Information: Please contact Digitarus for more information
X-Digitarus-vhost12-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-MailScanner-From: wiggly@wiggly.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vinay Venkataraghavan wrote:
> Hello,

Hello, *devil's advocate hat on*

> I have implemented an bare bones Intrusion detection
> system that currently detects scans like open, bouce,
> half open etc and a host of other tcp scans.

As an aside, why, we have snort?

> I would like to develop this into a full blown IDS
> which is capable of detecting buffer overflow attacks,
> sql injection etc. 
> 
> I know how to implement buffer overflow attacks. But
> how would an intrusion detection system detect a
> buffer overflow attack. My question is at the layer
> that the intrusion detection system operates, how will
> it know that a particular string for exmaple is liable
> to overflow a vulnerable buffer. 

Erm, if you know how some buffer overflow attacks work then surely the 
answer is "it depends on the application". To tell if an application is 
vulnerable you would have to audit it in some manner. Either by checking 
the source or doing some black-box testing on it.

Even if you did have a great big database of apps and had identifed 
which of them had possible vulnerabilities it would be easier to simply 
fix them rather than get an external system to disallow such inputs.

And not forgetting that you would have to have some way for your IDS to 
tell what app was running behind a specific port. Thought about that yet?

> Are there other open source firewall implementations
> other than snort?

Snort isn't a firewall. Don't mix apples and oranges. Snort is an IDS. 
The current de-facto "firewall" for linux is the iptables suite.

Cheers,

   n
