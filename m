Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbTFZOH1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 10:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbTFZOH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 10:07:27 -0400
Received: from smtprelay01.ispgateway.de ([62.67.200.160]:50391 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S261300AbTFZOH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 10:07:26 -0400
Message-ID: <3EFB0143.7000606@hipac.org>
Date: Thu, 26 Jun 2003 16:20:51 +0200
From: Michael Bellion and Thomas Heinz <nf@hipac.org>
Reply-To: Michael Bellion and Thomas Heinz <nf@hipac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: de, en
MIME-Version: 1.0
To: Daniel Egger <degger@fhm.edu>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: [ANNOUNCE] nf-hipac v0.8 released
References: <200306252248.44224.nf@hipac.org> <1056634720.5423.83.camel@sonja>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel

You wrote:
>>     - libnfhipac: netlink library for kernel-user communication
> 
> Is this library actually usable for applications which need to control
> the firewall or is it equally braindead to libiptables?

The library _is_ intended to be used by other applications than
the nf-hipac userspace tool, too. It hides the netlink communication
from the user who is only required to construct the command
data structure sent to the kernel which contains at most one single
nf-hipac rule. This is very straightforward and the kernel returns
detailed errors if the packet is misconstructed.

Taking a look at nfhp_com.h and evt. nf-hipac.c gives you some clue
on how to build valid command packets.


Regards,

+-----------------------+----------------------+
|   Michael Bellion     |     Thomas Heinz     |
| <mbellion@hipac.org>  |  <creatix@hipac.org> |
+-----------------------+----------------------+

