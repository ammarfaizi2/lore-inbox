Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVELTGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVELTGB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 15:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVELTGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 15:06:01 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:16249 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261373AbVELTFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 15:05:49 -0400
Subject: Re: Re[2]: ata over ethernet question
From: Dmitry Yusupov <dmitry_yus@yahoo.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sander <sander@humilis.net>,
       David Hollis <dhollis@davehollis.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <1115923927.5042.18.camel@mulgrave>
References: <1416215015.20050504193114@dns.toxicfilms.tv>
	 <1115236116.7761.19.camel@dhollis-lnx.sunera.com>
	 <1104082357.20050504231722@dns.toxicfilms.tv>
	 <1115305794.3071.5.camel@dhollis-lnx.sunera.com>
	 <20050507150538.GA800@favonius>
	 <Pine.LNX.4.60.0505102352430.9008@poirot.grange>
	 <1115923927.5042.18.camel@mulgrave>
Content-Type: text/plain
Date: Thu, 12 May 2005 12:05:47 -0700
Message-Id: <1115924747.25161.150.camel@beastie>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-12 at 14:52 -0400, James Bottomley wrote:
> On Wed, 2005-05-11 at 00:00 +0200, Guennadi Liakhovetski wrote:
> > A follow up question - I recently used nbd to access a CD-ROM. It worked 
> > nice, but, I had to read in 7 CDs, so, each time I had to replace a CD, I 
> > had to stop the client, the server, then replace the CD, re-start the 
> > server, re-start the client... I thought about extending NBD to (better) 
> > support removable media, but then you start thinking about all those 
> > features that your local block device has that don't get exported over 
> > NBD...
> 
> That's correct; NBD is basically just a remote data pipe type block
> device.  It doesn't understand arbitrary packet commands.
> 
> > Now, my understanding (sorry, without looking at any docs - yet) is, that 
> > iSCSI is (or at least should be) free from these limitations. So, does it 
> > make any sense at all extending NBD or just switch to iSCSI? Should NBD be 
> > just kept simple as it is or would it be completely superseeded by iSCSI, 
> > or is there still something that NBD does that iSCSI wouldn't (easily) do?
> 
> Caveat: I've done quite a bit of work on nbd, so I'm biased.  However,
> for what it does, nbd is extremely small, simple and efficient, so I
> think we'd want a hole in our head to replace it with something as
> complex and bloated as iSCSI---remember we'd need both a target and an
> initiator to do what nbd does today.

oh, please! don't compare nbd and iSCSI this way...
iSCSI is an emerging SAN technology, and the only technology to compare
is FC.

> However, there is room for improvement in nbd, notably the handling of
> packet commands, which looks to be eminently doable in the current
> infrastructure (this would basically make nbd a replicator for the linux
> block system, and would probably necessitate some client side changes to
> achieve).  If you have any thoughts in this direction, you could drop an
> email to the maintainer.
> 
> James
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

