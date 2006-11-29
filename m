Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967472AbWK2QmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967472AbWK2QmQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 11:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967473AbWK2QmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 11:42:16 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:39075 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S967472AbWK2QmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 11:42:15 -0500
Message-ID: <456DB875.2060306@oracle.com>
Date: Wed, 29 Nov 2006 08:42:29 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: Jiri Slaby <jirislaby@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
Subject: Re: [PATCH -mm] char: drivers use/need PCI
References: <20061128211203.fa197b15.randy.dunlap@oracle.com>	<456D4033.5000202@gmail.com>	<456DB203.1090108@oracle.com>	<456DB524.8000008@gmail.com> <20061129164130.2789bb84@localhost.localdomain>
In-Reply-To: <20061129164130.2789bb84@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
>> But those drivers support ISA devices too. Ok then, let "&& PCI" be as a correct
>> temporary way and I'll add "|| ISA" after the proposed code fix :).
> 
> That stops it being built on some platforms that have ISA and not PCI.
> Seems a poor fix for what really is a couple of ifdefs

They currently won't build for ISA because they always use the pci functions,
so yes, they do need to be fixed (correctly) --> Jiri :)

-- 
~Randy
