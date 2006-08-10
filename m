Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162203AbWHJNTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162203AbWHJNTU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 09:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161477AbWHJNTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 09:19:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:24978 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161476AbWHJNTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 09:19:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=Tvv+5qd4REF2MaUznq6zTNkyc8ZDD9u5u5WHCK+dU27ha1x3r6PHOOTyehVXj/Xmsc8bdjq+TRjzjNU8puX1xlQ2Vok4BY140sPLU+uvD/TKVdc1ci8wDeB0lH8E94r2UcBbXJrxleY4AFqhBbU9k9iHK1OqVMlllgoCrpbend4=
Date: Thu, 10 Aug 2006 15:19:16 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: David Miller <davem@davemloft.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net,
       jet@gyve.org
Subject: Re: [patch] Use rwsems instead of custom locking scheme in net/socket.c and net/dccp/ccid.c
Message-ID: <20060810131916.GA1221@slug>
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <20060810121336.GB1462@slug> <20060810.055711.56053014.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060810.055711.56053014.davem@davemloft.net>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 05:57:11AM -0700, David Miller wrote:
> From: Frederik Deweerdt <deweerdt@free.fr>
> Date: Thu, 10 Aug 2006 14:13:36 +0200
> 
> > This patch aims at removing two implementations (spotted by Masatake YAMATO) of
> > pseudo-rwlocks using a spinlock_t and an atomic_t. One in net/socket.c
> > and another in net/bluetooth/af_bluetooth.c. I think that both could be
> > converted to rwsems, saving some lines of code.
> 
> The net/socket.c one has been converted to RCU by Stephen
> Hemminger already.
> 
> If the bluetooth case is in an important code path it should
> use RCU as well.
Sorry, I made a mistake there: net/bluetooth/af_bluetooth.c should read
net/dccp/ccid.c. Does your comment regarding af_bluetooth.c applies to
ccid.c as well?
Also, is there a place where I can find Stephen Hemminger's work?
- Note, this is pure curiosity, it can wait a kernel release or two :) -

Thanks,
Frederik
