Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269846AbUJHLfC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269846AbUJHLfC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 07:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269864AbUJHLeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 07:34:00 -0400
Received: from open.hands.com ([195.224.53.39]:7625 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S269863AbUJHL0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 07:26:10 -0400
Date: Fri, 8 Oct 2004 12:37:10 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
       lkml <linux-kernel@vger.kernel.org>, SELinux@tycho.nsa.gov,
       Ingo Molnar <mingo@redhat.com>, netdev@oss.sgi.com,
       linux-net@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm4-VP-S7 - ksoftirq and selinux oddity
Message-ID: <20041008113710.GC5551@lkcl.net>
Mail-Followup-To: Stephen Smalley <sds@epoch.ncsc.mil>,
	Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
	lkml <linux-kernel@vger.kernel.org>, SELinux@tycho.nsa.gov,
	Ingo Molnar <mingo@redhat.com>, netdev@oss.sgi.com,
	linux-net@vger.kernel.org
References: <200410070542.i975gkHV031259@turing-police.cc.vt.edu> <1097157367.13339.38.camel@moss-spartans.epoch.ncsc.mil> <20041008093154.GA5089@lkcl.net> <1097234322.16641.3.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097234322.16641.3.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 07:18:42AM -0400, Stephen Smalley wrote:
> On Fri, 2004-10-08 at 05:31, Luke Kenneth Casson Leighton wrote:
> >  an alternative possible solution is to get the packet _out_ from
> >  the interrupt context and have the aux pid comm exe information added.
> 
> No, the network permission checks are intentionally layered to match the
> network protocol implementation.  There is a process-to-socket check
> performed in process context when the data is received from the socket
> by an actual process, but there is also the socket-to-netif/node/port
> check performed in softirq context when the packet is received on the
> socket from the network.
 
 ah.  oh well!

