Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVFNH40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVFNH40 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 03:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVFNH4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 03:56:25 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:24202 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261313AbVFNH4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 03:56:16 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: Input sysbsystema and hotplug
Date: Tue, 14 Jun 2005 02:56:09 -0500
User-Agent: KMail/1.8.1
Cc: linux-hotplug-devel@lists.sourceforge.net,
       Kay Sievers <kay.sievers@vrfy.org>, Greg KH <gregkh@suse.de>,
       Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200506131607.51736.dtor_core@ameritech.net> <200506140242.08982.dtor_core@ameritech.net> <42AE8BA4.5020702@suse.de>
In-Reply-To: <42AE8BA4.5020702@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506140256.10313.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 June 2005 02:47, Hannes Reinecke wrote:
> Dmitry Torokhov wrote:
> > On Tuesday 14 June 2005 02:32, Hannes Reinecke wrote:
> >>And yes, we should break compability and come up with a clean
> >>implementation.
> > 
> > But those pesky users scream every time we break their mice ;)
> > 
> >>And as the original input event is an abomination I 
> >>don't see the point in keeping compability with a broken interface.
> >>
> > 
> > Why is it abomination (aside from using old mechanism to call
> > hotplug)? It looks like it transmits all data necessary to load
> > appropriate input handler...
> > 
> Because there are _two_ events with the name 'input'.
> Both run under the same name but carry different information.
> One is required to load the module and the other is required to create
> the device node.
> 
> That's what I call an abomination.
>

Ah, I see. Yep, it "input" wasn't reused when input_handlers were converted
to class_simple we probably would not have this discussion now.

-- 
Dmitry
