Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWIKMD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWIKMD1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 08:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWIKMD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 08:03:27 -0400
Received: from tresys.irides.com ([216.250.243.126]:36721 "HELO
	exchange.columbia.tresys.com") by vger.kernel.org with SMTP
	id S1751320AbWIKMD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 08:03:26 -0400
Message-ID: <4505508A.1060105@gentoo.org>
Date: Mon, 11 Sep 2006 08:03:22 -0400
From: Joshua Brindle <method@gentoo.org>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: David Madore <david.madore@ens.fr>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 3/4] security: capabilities patch (version 0.4.4), part
 3/4: introduce new capabilities
References: <20060910133759.GA12086@clipper.ens.fr> <20060910134257.GC12086@clipper.ens.fr> <1157905393.23085.5.camel@localhost.localdomain> <20060910160953.GA6430@clipper.ens.fr> <Pine.LNX.4.64.0609110402250.15565@d.namei>
In-Reply-To: <Pine.LNX.4.64.0609110402250.15565@d.namei>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: avast! (VPS 0636-3, 09/08/2006), Outbound message
X-Antivirus-Status: Clean
X-OriginalArrivalTime: 11 Sep 2006 12:03:26.0068 (UTC) FILETIME=[49745B40:01C6D59A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:
> On Sun, 10 Sep 2006, David Madore wrote:
>
>   
>> Can a non-root user create limited-rights processes without assistance
>> from the sysadmin, under SElinux?
>>     
>
> SELinux uses a restrictive model, where privileges can only be removed, 
> not added.
>
>   
I think he was asking if a non-admin user can create processes of less 
privilege without becoming root. The answer is yes, however, it is 
policy driven. Users will have numerous 'derived' types that are less 
privilege than, for example, their interactive shell. For example, 
user_irc_t or user_evolution_t. The transitions will happen when the 
user runs irc or evolution and those apps will be limited to the rights 
they require. These are fine grained though, and mandatory. These 
capabilities are so course grained I just can't see anyone ever using them.
