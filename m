Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317191AbSHGKxt>; Wed, 7 Aug 2002 06:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317209AbSHGKxt>; Wed, 7 Aug 2002 06:53:49 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:26105 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317191AbSHGKxs>; Wed, 7 Aug 2002 06:53:48 -0400
Subject: Re: 64bit clean drivers was Re: Linux 2.4.20-pre1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020807124153.A8592@wotan.suse.de>
References: <200208062329.g76NTqP30962@devserv.devel.redhat.com.suse.lists.linux.kernel>
	 <p73vg6nhtsb.fsf@oldwotan.suse.de>
	<1028721043.18478.265.camel@irongate.swansea.linux.org.uk> 
	<20020807124153.A8592@wotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Aug 2002 13:16:48 +0100
Message-Id: <1028722608.18156.280.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-07 at 11:41, Andi Kleen wrote:
> I don't see why it is unmaintainable. What is so bad with these ifs? 
> 64bit cleanness is just another dependency, nothing magic and fundamentally
> hard.

Lets take I2O block the if rule would

if [ $CONFIG_X86 = "y" -a $CONFIG_X86_64 != "y" ] 
	dep_bool ...
fi
if [ $CONFIG_ALPHA = "y" &&  other conditions ...]
	dep_bool ...
fi

and so on

The actual rule being if 32bit little endian || 64bit little endian with
kernel memory objects always below 4Gb and having PCI bus


Thats just one non too complicated driver. CML1 can't handle this
scalably, maybe CML2 could have. 

Secondly you actually want people to discover stuff doesn't work so you
can persuade them to go and fix it. Stick up a 'Good/Probably
Ok/Bad/Hopeless' driver listing on x86_64.org, then once Hammer becomes
in general use post it to the janitor list now and then

Alan

