Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbUDRRbn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 13:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUDRRbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 13:31:43 -0400
Received: from florence.buici.com ([206.124.142.26]:12929 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S262213AbUDRRbl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 13:31:41 -0400
Date: Sun, 18 Apr 2004 10:31:39 -0700
From: Marc Singer <elf@buici.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>, Marc Singer <elf@buici.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
Subject: Re: NFS and kernel 2.6.x
Message-ID: <20040418173139.GA28744@flea>
References: <1082093346.7141.159.camel@lade.trondhjem.org> <pan.2004.04.17.16.44.00.630010@smurf.noris.de> <1082225747.2580.18.camel@lade.trondhjem.org> <20040417183219.GB3856@flea> <1082228313.2580.25.camel@lade.trondhjem.org> <20040417222258.GA12893@flea> <1082249866.3619.43.camel@lade.trondhjem.org> <20040418050141.GA19414@flea> <408221DE.4050002@nortelnetworks.com> <20040418085619.A4239@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040418085619.A4239@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2004 at 08:56:19AM +0100, Russell King wrote:
> On Sun, Apr 18, 2004 at 02:36:14AM -0400, Chris Friesen wrote:
> > Marc Singer wrote:
> > 
> > > Client is a 200MHz ARM; server is a Linux host running 2.6.3 with the
> > > kernel nfs daemon; network is 100Mib.  There is nothing else on the
> > > network except intermittent broadband traffic.  Async is set on the
> > > server side.
> > 
> > Is the ARM that slow?  under 2MB/s seems odd to me...but them maybe I'm 
> > used to faster machines.
> 
> It's probably the SMC91c111 ether chip causing all the problem - it's
> only able to store about 4 packets before it starts dropping, which
> isn't that much on a 100mbit network.

I suspect that it might be a CPU issue.  On transmit only, it never
gets above 18Mib.

> Running with rsize=4096 works wonders with this chip.

Already there.

