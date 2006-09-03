Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWICN43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWICN43 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 09:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWICN43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 09:56:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:5503 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751103AbWICN42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 09:56:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IdkifDRsn3Q+qkwCZQkXr2ASys2CQ/vCMvHJsuGxJoxjQGDL3su6+3dIlXdFn8w4A1XmDf7V51p8OaKBK0nCU/SY82zUI3R8ZEmNRKsCdoAPbsK1lkexNQ3W4TGNkCWqGuuDY6Kho+f0cIhdD+m53Ewz2ihwgvuRLompa+X0Oeo=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: shogunx <shogunx@sleekfreak.ath.cx>
Subject: Re: sky2 hangs on me again: This time 200 kb/s IPv4 traffic, not easily reproducable
Date: Sun, 3 Sep 2006 15:55:24 +0200
User-Agent: KMail/1.8.2
Cc: Matthias Hentges <oe@hentges.net>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       Stephen Hemminger <shemminger@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0609021939100.28542-100000@sleekfreak.ath.cx>
In-Reply-To: <Pine.LNX.4.44.0609021939100.28542-100000@sleekfreak.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609031555.24901.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 September 2006 01:49, shogunx wrote:
> > > > Well, it just crapped out on me again :(
> > > >
> > > > Sep  2 23:36:13 localhost kernel: NETDEV WATCHDOG: eth2: transmit timed
> > > > out
> > > > Sep  2 23:36:13 localhost kernel: sky2 hardware hung? flushing
> > > >
> > > > Only a rmmod / modprobe cycle helps at this point.
> > >
> > > Really?  What is the error condition causing it?  On my friends lap, which
> > > has an integrated sky2, his drops out with a full sustained TX...
> > > uploading to another box for example, at about 4-8MB of transfer.  The
> > > fix in his case is ifdown eth0 && ifup eth0.  I have
> > > yet to see the error occur at all on my ExpressCard device, either with
> > > 2.6.18-rc5 or 2.6.17.5.  I built the rc5 as a preemptive measure, but I
> > > cannot get it to fail under any conditions.
> > >
> >
> > I have yet to find a reproduceable way to trigger the bug but I'll try a
> > few things tomorrow.
> > Currently it appears to be completely ranom. I've loaded the driver w/
> > debug=10, maybe it'll give some clues.
> 
> Ack.  Awaiting more info.  I pushed it pretty hard last night with both
> kernel revisions, scp'ing cd iso images and kernel tarballs back and forth
> across the interface, and could not get it to lock.  I am using a 88E8053
> chipset.  I'll ask my friend what chipset his is.  Perhaps its a
> different bug that is hitting you now...

scp isn't "pushing very hard". It takes some time to do ssh crypto
and even if your CPU is fast enough for that to be not an issue,
scp is using TCP, which is _designed_ to not saturate links to 100.00%.

Give it a real hard beating with uni- and bidirectional UDP netcat flood! :)
--
vda

-- 
VGER BF report: U 0.511791
