Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263031AbUB0WKI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 17:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbUB0WJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 17:09:54 -0500
Received: from codepoet.org ([166.70.99.138]:15516 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S263167AbUB0WIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 17:08:40 -0500
Date: Fri, 27 Feb 2004 15:08:38 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       John Bradford <john@grabjohn.com>, Erik van Engelen <Info@vanE.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Errors on 2th ide channel of promise ultra100 tx2
Message-ID: <20040227220837.GA984@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	John Bradford <john@grabjohn.com>, Erik van Engelen <Info@vanE.nl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
References: <403F2178.70806@vanE.nl> <Pine.LNX.4.58L.0402271420250.18958@logos.cnet> <200402271820.i1RIKVLb000744@81-2-122-30.bradfords.org.uk> <Pine.LNX.4.58L.0402271629430.19209@logos.cnet> <1077908499.29713.19.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077908499.29713.19.camel@dhcp23.swansea.linux.org.uk>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Feb 27, 2004 at 07:01:41PM +0000, Alan Cox wrote:
> On Gwe, 2004-02-27 at 19:30, Marcelo Tosatti wrote:
> > > > Haven't got a clue about these "status=0x51" and "error=0x04". Anyone?
> > >
> > > Basically, the errors mean what they say - the drive is in an error
> > > state, (received an unrecognised command), but is ready for further
> > > operation.
> > 
> > Received an unrecognised command from the kernel? What can cause that?
> 
> Our early setup/probing code in 2.4.x at least may send stuff that very
> very old disks don't understand. Its arguably a bug in the ident parsing
> but it shouldnt ever be harmful

Yes it is potentially harmful.  Old drives that can't grok HPA
are asked if they have an HPA, which i.e. will cause my old
Samsung 400 MB drive to become very unhappy.  I sent in a patch
fixing it quite a while back.  It was accepted into 2.6.x but the
2.4.x version never made it in...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
