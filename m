Return-Path: <linux-kernel-owner+w=401wt.eu-S932105AbXAVRx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbXAVRx3 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 12:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbXAVRx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 12:53:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:48882 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932105AbXAVRx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 12:53:28 -0500
X-Authenticated: #5039886
Date: Mon, 22 Jan 2007 18:53:22 +0100
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Robert Hancock <hancockr@shaw.ca>, Jeff Garzik <jeff@garzik.org>,
       Chr <chunkeey@web.de>, Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org, htejun@gmail.com, jens.axboe@oracle.com,
       lwalton@real.com, pomac@vapor.com
Subject: Re: SATA exceptions with 2.6.20-rc5
Message-ID: <20070122175321.GA2647@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Robert Hancock <hancockr@shaw.ca>, Jeff Garzik <jeff@garzik.org>,
	Chr <chunkeey@web.de>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	linux-kernel@vger.kernel.org, htejun@gmail.com,
	jens.axboe@oracle.com, lwalton@real.com, pomac@vapor.com
References: <45B2DF43.8080304@garzik.org> <20070121045437.GA7387@atjola.homenet> <45B30A98.3030206@shaw.ca> <20070121083618.GA2434@atjola.homenet> <20070121184032.GA3220@atjola.homenet> <45B3C5C9.4010007@shaw.ca> <20070121222714.GA2473@atjola.homenet> <45B4027D.30805@shaw.ca> <20070122161239.GA2402@atjola.homenet> <20070122165707.GA5936@atjola.homenet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20070122165707.GA5936@atjola.homenet>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2007.01.22 17:57:08 +0100, Björn Steinbrink wrote:
> On 2007.01.22 17:12:40 +0100, Björn Steinbrink wrote:
> > On 2007.01.21 18:17:01 -0600, Robert Hancock wrote:
> > > Hmm, another miss, apparently.. Has anyone tried removing these lines
> > > >from nv_host_intr in 2.6.20-rc5 sata_nv.c and see what that does?
> > > 
> > >     /* bail out if not our interrupt */
> > >     if (!(irq_stat & NV_INT_DEV))
> > >         return 0;
> > 
> > Running a kernel with the return statement replace by a line that prints
> > the irq_stat instead.
> > 
> > Currently I'm seeing lots of 0x10 on ata1 and 0x0 on ata2.
> 
> 40 minutes stress test now and no exception yet. What's interesting is
> that ata1 saw exactly one interrupt with irq_stat 0x0, all others that
> might have get dropped are as above.
> I'll keep it running for some time and will then re-enable the return
> statement to see if there's a relation between the irq_stat 0x0 and the
> exception.

No, doesn't seem to be related, did get 2 exceptions, but no irq_stat
0x0 for ata1. Syslog/dmesg has nothing new either, still the same
pattern of dismissed irq_stats.

Björn
