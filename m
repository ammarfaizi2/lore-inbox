Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbUBTTnU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 14:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbUBTTmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 14:42:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:2225 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261378AbUBTTej convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 14:34:39 -0500
Date: Fri, 20 Feb 2004 11:34:27 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Andrew Walrond <andrew@walrond.org>
Cc: YOSHIFUJI Hideaki / =?ISO-8859-1?B?X19fX19fX19fX19f?= 
	<yoshfuji@linux-ipv6.org>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.3 : [eth0: Too much work at interrupt,
 status=0x00000001.]
Message-Id: <20040220113427.0a088fb9@dell_ss3.pdx.osdl.net>
In-Reply-To: <200402201915.09342.andrew@walrond.org>
References: <200402201803.12146.andrew@walrond.org>
	<20040221.032006.68375681.yoshfuji@linux-ipv6.org>
	<200402201915.09342.andrew@walrond.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Feb 2004 19:15:09 +0000
Andrew Walrond <andrew@walrond.org> wrote:

> On Friday 20 Feb 2004 6:20 pm, YOSHIFUJI Hideaki / ____________ wrote:
> > In article <200402201803.12146.andrew@walrond.org> (at Fri, 20 Feb 2004 
> 18:03:11 +0000), Andrew Walrond <andrew@walrond.org> says:
> >
> > I've got this several times, randomly, and
> > I had to go to the console to reboot the machine.
> >
> 
> Well the machine and network (at least with just ssh access) is working fine
> 
> I left the machine (which is a remote rack-mounted server) for an hour and now 
> there is perhaps 120 of these warnings. Net is still working though.
> 
> Unless anyone has any ideas, I'll move back to 2.4 on this machine
> 
> Andrew

The driver needs to be converted to NAPI to sustain high network loads.
The existing driver allocates and copies each receive packet in the interrupt routine.

See the recent revision of 8139too to see what that entails.
