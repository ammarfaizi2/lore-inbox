Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVCKTKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVCKTKq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 14:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVCKTFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 14:05:08 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:37976 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261380AbVCKS5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 13:57:00 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: Last night Linus bk - netfilter busted?
Date: Fri, 11 Mar 2005 13:56:53 -0500
User-Agent: KMail/1.7.2
Cc: Patrick McHardy <kaber@trash.net>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
References: <200503110223.34461.dtor_core@ameritech.net> <4231A498.4020101@trash.net> <20050311105136.2a5e4ddc.davem@davemloft.net>
In-Reply-To: <20050311105136.2a5e4ddc.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503111356.53620.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 March 2005 13:51, David S. Miller wrote:
> On Fri, 11 Mar 2005 15:00:56 +0100
> Patrick McHardy <kaber@trash.net> wrote:
> 
> > Works fine here. You could try if reverting one of these two patches
> > helps (second one only if its a SMP box).
> > 
> > ChangeSet@1.2010, 2005-03-09 20:28:17-08:00, bdschuym@pandora.be
> >    [NETFILTER]: Reduce call chain length in netfilter (take 2)
> 
> It's this change, I know it is, because Linus sees the same problem
> on his workstation.
> 
> You wouldn't happen to be seeing this problem on a PPC box would
> you?  Since Linus's machine is a PPC machine too, that would support
> my theory that this could be a compiler issue on that platform.
> 

No, it is regular PIII laptop (preempt, UP).

> Damn, wait, Patrick, I think I know what's happening.  The iptables
> IPT_* verdicts are dependant upon the NF_* values, and they don't
> cope with Bart's changes I bet.  Can you figure out what the exact
> error would be?  This kind of issue would explain the looping inside
> of ipt_do_table(), wouldn't it?
> 

-- 
Dmitry
