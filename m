Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269204AbTGOR2p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 13:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269207AbTGOR2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 13:28:45 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:60168 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269204AbTGOR2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 13:28:44 -0400
Date: Tue, 15 Jul 2003 18:43:32 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Dave Jones <davej@codemonkey.org.uk>, <dank@reflexsecurity.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1-ac1 Matrox Compile Error
In-Reply-To: <1058290204.3857.51.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0307151833310.7746-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >  > > you'll need to build VT support.
> >  > Ug. That is wrong. Fbdev driver are independent of the console layer.
> > 
> > Regardless, the number of people falling over this issue is still
> > somewhere in the region of "silly".
> > The only people who would want to turn off VT support are likely to
> > be embedded folks, so why not move this under CONFIG_EMBEDDED ?
> > and force it to '=y' for everyone else ?
> 
> Seconded  - care to send me a diff for -ac2 8)

   This still doesn't solve the issue with the input api. The input layer 
can be modular on many levels. Even if we force the input core to be built in 
this will not stop people from building the keyabord drivers as modules. 
Having PS/2 support always turned to Y will not also work since there are 
systems that use just USB. Their is a point where users will just have to 
read the README and follow directions. We can't make people do the right 
thing.
   Also doing this kind of thing only covers up broken framebuffer 
drivers. Unfortunetly its going to take me months to cleanup and make the 
fbdev drivers behave right. 

