Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWEWJyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWEWJyr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 05:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWEWJyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 05:54:47 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:26318 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S932155AbWEWJyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 05:54:46 -0400
In-Reply-To: <4471CE19.5070802@trash.net>
References: <4468BE70.7030802@tektonic.net> <4468D613.20309@trash.net>	<44691669.4080903@tektonic.net>	<Pine.LNX.4.64.0605152331140.10964@d.namei>	<4469D84F.8080709@tektonic.net>	<Pine.LNX.4.64.0605161127030.16379@d.namei>	<446D0A0D.5090608@tektonic.net>	<Pine.LNX.4.64.0605182002330.6528@d.namei> <446D0E6D.2080600@tektonic.net> <446D151D.6030307@tektonic.net> <4470A6CD.5010501@trash.net> <4471CB54.401@tektonic.net> <4471CE19.5070802@trash.net>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fb268aac0218b2a558e922858f99b20b@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: James Morris <jmorris@namei.org>,
       "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matt Ayres <matta@tektonic.net>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [Xen-devel] Re: Panic in ipt_do_table with 2.6.16.13-xen
Date: Tue, 23 May 2006 10:54:35 +0100
To: Patrick McHardy <kaber@trash.net>
X-Mailer: Apple Mail (2.624)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22 May 2006, at 15:43, Patrick McHardy wrote:

> The only other thing I can imagine is that something is wrong with
> the per-CPU copy of the ruleset, i.e. either smp_processor_id is
> returning garbage or for_each_possible_cpu misses a CPU during
> initialization. I have no idea if Xen really does touch this code,
> but other than that I don't really see what it could break.

Of the options you consider, this sounds most likely. Really we need 
some more info from a crash: I'd like to get disassembly from a vmlinux 
image if that's possible, Matt.

  Thanks,
  Keir

