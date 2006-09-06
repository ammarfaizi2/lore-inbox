Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWIFQEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWIFQEd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 12:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWIFQEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 12:04:33 -0400
Received: from 66-117-159-244.lmi.net ([66.117.159.244]:3054 "EHLO slick.org")
	by vger.kernel.org with ESMTP id S1751351AbWIFQEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 12:04:31 -0400
Message-ID: <44FEF18C.5060305@imvu.com>
Date: Wed, 06 Sep 2006 09:04:28 -0700
From: "Brett G. Durrett" <brett@imvu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Lloyd <dlloyd@exegy.com>
CC: Sumant.Patro@lsil.com, Sreenivas.Bagalkote@lsil.com,
       lkml <linux-kernel@vger.kernel.org>, Berkley Shands <bshands@exegy.com>
Subject: Re: megaraid_sas waiting for command and then offline
References: <44FE536C.8080000@imvu.com> <44FED723.5050107@exegy.com>
In-Reply-To: <44FED723.5050107@exegy.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The machines are Dell 2900s, so the mobo is custom.  From a Dell SE, 
"Dell uses a custom mobo that is Dell branded with the Intel chipset 
Greencreek.".

B-




Dave Lloyd wrote:

> Brett G. Durrett wrote:
> >
> > I have the same or a similar issue running 2.6.17 SMP x86_64 - the
> > megaraid_sas driver hangs waiting for commands and then the filesystem
> > unmounts, leaving the machine in an unusable state until there is a 
> hard
> > reboot (the machine is responsive but any access, shell or 
> otherwise, is
> > impossible without the filesystem).  While I do not have much debugging
> > information available, this happens to me about once every 6-7 days in
> > my pool of seven machines, so I can probably get debugging info.  Since
> > the disk is offline and I can't get remote console, I don't have any
> > details except something similar to Dave Lloyd's post, below.
> >
> > The only thing that the machines with these failures seem to have in
> > common is the fact that they are almost exclusively writes - they are
> > slave database machines with large memory and pretty much just
> > replicate.  The read/write machines seem to have less failures.
> >
> > I am happy to help provide debugging information in any reasonable way.
> > In the mean time, if there are any known suggestions or workarounds for
> > the problem, I would be grateful for the guidance.
> >
> > Here are what details on the controller.  If you want additional info,
> > let me know exactly what you need and I will do what I can to get it to
> > you.:
> >
> > Product Name    : PERC 5/i Integrated
> > Serial No       : 12345
> > FW Package Build: 5.0.1-0030
> > FW Version      : 1.00.01-0088
> > BIOS Version    : MT23
> > Ctrl-R Version  :1.02-007
> >
> > B-
>
> Which motherboard are you using?  We believe that this may be a
> motherboard specific issue.  It appears to happen on a SuperMicro
> motherboard but not a Tyan motherboard.
>
