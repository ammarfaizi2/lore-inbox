Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264763AbUGESvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264763AbUGESvp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 14:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266167AbUGESvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 14:51:45 -0400
Received: from web51808.mail.yahoo.com ([206.190.38.239]:33894 "HELO
	web51808.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264763AbUGESvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 14:51:39 -0400
Message-ID: <20040705185138.96848.qmail@web51808.mail.yahoo.com>
Date: Mon, 5 Jul 2004 11:51:38 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: [still problems] Re: Slow internet access for 2.6.7bk15&16
To: Phy Prabab <phyprabab@yahoo.com>, bert hubert <ahu@ds9a.nl>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20040705181747.83811.qmail@web51808.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Concerning my issue with ftp'ing from remote sites,
using these sysctl's I was able to get the performance
back:

net.ipv4.tcp_default_win_scale=0
net.ipv4.tcp_moderate_rcvbuf=0



2.6.7-bk18 w/out sysctls:
2573621 bytes received in 2e+02 seconds (12 Kbytes/s)
ftp> by

2.6.7-bk18 w/sysctls:
2573621 bytes received in 0.69 seconds (3.6e+03
Kbytes/s)
ftp> by


I am curious why I must set these on the newer kernels
or is this something that is being addressed?  Is this
an issue with firewalls?

Thank you for your time.
Phy



--- Phy Prabab <phyprabab@yahoo.com> wrote:
> Appreciate the tips and help!
> Phy
> 
> --- bert hubert <ahu@ds9a.nl> wrote:
> > On Sun, Jul 04, 2004 at 04:28:52PM -0700, Phy
> Prabab
> > wrote:
> > > Okay, so, I checked the latest bk (17) and found
> > that
> > > the fix indicated by the below link has already
> > made
> > > it in and still I see the slow down in ftp
> > transfers
> > > in comparison to 2.6.6 and 2.4.x kernels.  Any
> > > suggestions?
> > 
> > I've forwarded your message to netdev@oss.sgi.com,
> > but see also
> >
>
http://groups.google.com/groups?selm=2emz3-6GV-5%40gated-at.bofh.it&output=gplain
> > 
> > Good luck!
> > 
> > > 
> > > Dual Opteron
> > > Broadcom Ge
> > > using tg3
> > > 
> > > Thanks!
> > > Phy
> > > --- bert hubert <ahu@ds9a.nl> wrote:
> > > > On Sat, Jul 03, 2004 at 07:41:12PM -0700, Phy
> > Prabab
> > > > wrote:
> > > > > Heelo,
> > > > > 
> > > > > I have been watching a thread concerning the
> > slow
> > > > down
> > > > > with accessing some websites but have not
> > found a
> > > > > resolution to the issue.  
> > > > 
> > > > Probably fixed by
> > > >
> > >
> >
>
http://linus.bkbits.net:8080/linux-2.5/cset@40e47ae2tQ_PIxw_HStw3YgsdJFHow?nav=index.html|ChangeSet@-4d
> > > > 
> > > > -- 
> > > > http://www.PowerDNS.com      Open source,
> > database
> > > > driven DNS Software 
> > > > http://lartc.org           Linux Advanced
> > Routing &
> > > > Traffic Control HOWTO
> > > > -
> > > > To unsubscribe from this list: send the line
> > > > "unsubscribe linux-kernel" in
> > > > the body of a message to
> > majordomo@vger.kernel.org
> > > > More majordomo info at 
> > > > http://vger.kernel.org/majordomo-info.html
> > > > Please read the FAQ at 
> http://www.tux.org/lkml/
> > > > 
> > > 
> > > 
> > > 
> > > 		
> > > __________________________________
> > > Do you Yahoo!?
> > > New and Improved Yahoo! Mail - Send 10MB
> messages!
> > > http://promotions.yahoo.com/new_mail 
> > > -
> > > To unsubscribe from this list: send the line
> > "unsubscribe linux-kernel" in
> > > the body of a message to
> majordomo@vger.kernel.org
> > > More majordomo info at 
> > http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> > -- 
> > http://www.PowerDNS.com      Open source, database
> > driven DNS Software 
> > http://lartc.org           Linux Advanced Routing
> &
> > Traffic Control HOWTO
> > -
> > To unsubscribe from this list: send the line
> > "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> > http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> 
> 
> 		
> __________________________________
> Do you Yahoo!?
> Yahoo! Mail - 50x more storage than other providers!
> http://promotions.yahoo.com/new_mail
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
