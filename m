Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266352AbUIIVdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266352AbUIIVdr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 17:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267312AbUIIVbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 17:31:20 -0400
Received: from open.hands.com ([195.224.53.39]:989 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S268000AbUIIV06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 17:26:58 -0400
Date: Thu, 9 Sep 2004 22:38:13 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] update: _working_ code to add device+inode check to ipt_owner.c
Message-ID: <20040909213813.GC10892@lkcl.net>
References: <20040909162200.GB9456@lkcl.net> <20040909091931.K1973@build.pdx.osdl.net> <20040909181034.GF10046@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909181034.GF10046@lkcl.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 07:10:34PM +0100, Luke Kenneth Casson Leighton wrote:

> On Thu, Sep 09, 2004 at 09:19:31AM -0700, Chris Wright wrote:
> > * Luke Kenneth Casson Leighton (lkcl@lkcl.net) wrote:
> > > wow, gosh, it works.
> > > 
> > > okay, this is a patch to add support in iptables for per-program
> > > firewall filtering.
> > > 
> > > also included is the patches to iptables-1.2.11.
> > > 
> > > i have confidence that this patch will provide support for
> > > BOTH incoming AND outgoing per-program packet filtering.
> > 
> > Programs can share a socket.  Incoming is in interrupt context.  You
> > have no idea who will be woken up.  How do you handle this?
>  
>  chris, hi,

chris - for example, i notice that at the top of ipt_owner.c it says
"deals with local outgoing sockets".

so... does sk_buff _only_ contain a list of outgoing sockets?

iiiisss... there a different socket for incoming traffic that
someone is different from the list of sockets associated with
a task?

is the clue in what you say about "Incoming is in interrupt context"?

are the sockets in the interrupt context somehow different / special
such that they would never get to this code?

gloop, gloop, i'm drowning in lack of knowledge, here.

l.

