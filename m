Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWAJClL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWAJClL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 21:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWAJClK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 21:41:10 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:48146 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750972AbWAJClJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 21:41:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A8epFBGOGhAdeKBsqT3ZyyBgck9zI6WNIFv3ulrgjo1WMie7iovCEG1FXJGx/k639Uo6bFIrHbc1QI3QRV2vaUK81ciO7jE2dzl+zMdmVCT/n2VQht7K+kMlFQX6mx3mkE9qNCdcYCixSjx+NbuBRjjtkSI9zcAdKJe6axeqHt0=
Message-ID: <4807377b0601091841j76c6093an8117ad66cd32981@mail.gmail.com>
Date: Mon, 9 Jan 2006 18:41:08 -0800
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: Leroy van Logchem <leroy.vanlogchem@gmail.com>
Subject: Re: PROBLEM: bug in e1000 module causes very high CPU load
Cc: linux-kernel@vger.kernel.org,
       Kernel Netdev Mailing List <netdev@vger.kernel.org>,
       ph0x <ph0x@freequest.net>
In-Reply-To: <b7561c4a0512231514y3bd6564jd13d16ea4476f07e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4807377b0512101416t2f3a04c5ua6859ab3d99e8d07@mail.gmail.com>
	 <20051211194114.GBCH17186.mxfep02.bredband.com@ph0x>
	 <b7561c4a0512231514y3bd6564jd13d16ea4476f07e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/05, Leroy van Logchem <leroy.vanlogchem@gmail.com> wrote:
> <snip>
> > Yes, let the server act as usual, it just starts happening out of the blue.
> > No new hardware has been added or removed, no new programs has been
> > installed.
>
> "Me too"

<snip>

> Is there a method which can give hints about what was going on during
> the sharply rising load? My guess is that even monitoring/sampling

well, maybe top, maybe you could schedule sar to gather stats on your system.

> aint doable anymore if the bad situation occurs. Tips on obtaining
> information about subjects like:
> - who was using which tcp/udp connection with what bandwidth

i like a utility like iptraf to help with this.

> - who was generating how many read/writes on which filesystem incl. location

hm, thats a little tougher, nfsstat doesn't give that does it.

> - etc etc.
> are more then welcome too. Does using profile=2 and storing
> readprofile output to files every 5 seconds give enough information to
> tacle the source of this problem?

yes, i think that would certainly help figure out what happens at the TOD :-)
you could enable sysrq in order to get a stack after it hung.  For
bonus points you can hook up a serial console and dump the state of
all processes with sysrq.

hopefully before it died you would be able to sync your drive and
reboot in order to maximize your chances of fully writing files.

Jesse
