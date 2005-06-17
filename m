Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbVFQNUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbVFQNUL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 09:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbVFQNSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 09:18:32 -0400
Received: from nproxy.gmail.com ([64.233.182.205]:22197 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261962AbVFQNSG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 09:18:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oM7reqF/7oVCxzo+/NdJZv7s+5j7y5o0KwkWW8AW05fuxzarrupCbJHMzwrI37+NcL6OyakikZdc5Hn3qE0z6gt/B7Amhv+41pBN0uDRImuxni/55q1fPYBFO+/dhm9ojOuROQt4FTLc1I+xgXJqSOrtxvP6+ySFTjhbMNORop8=
Message-ID: <4ad99e05050617061864f286a2@mail.gmail.com>
Date: Fri, 17 Jun 2005 15:18:03 +0200
From: Lars Roland <lroland@gmail.com>
Reply-To: Lars Roland <lroland@gmail.com>
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: tg3 in 2.6.12-rc6 and Cisco PIX SMTP fixup
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       Christian Kujau <evil@g-house.de>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200506171306.j5HD6E01001899@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ad99e0505061605452e663a1e@mail.gmail.com>
	 <42B1F5CB.9020308@g-house.de>
	 <4ad99e0505061615143cc34192@mail.gmail.com>
	 <42B21130.4000608@g-house.de>
	 <4ad99e0505061617052f427ed6@mail.gmail.com>
	 <42B218C5.9020406@linuxwireless.org>
	 <4ad99e0505061618475716f13c@mail.gmail.com>
	 <200506171306.j5HD6E01001899@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/05, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> On Fri, 17 Jun 2005 03:47:00 +0200, Lars Roland said:
> > 
> >
> > On 6/17/05, Alejandro Bonilla <abonilla@linuxwireless.org> wrote:
> > > one question,
> > >
> > >     Can I know what is the problem?
> > >:I have 2 tg3 adapters, lots e100's and some Cisco PIX and devices.
> > >
> > > I can try to reproduce it and see if anyone has something to say about it.
> >
> > Yes please. As I see it. Enable smtp fixup protocol on your cisco pix
> > (you will need to have a smtp server to point it to), then on some
> > linux system running with a kernel greater than 2.6.8.1 do a telnet to
> > the smtp server that is firewalled and try to issue a smtp command.
> >
> > Note that cisco has a bug report on smtp fixup banner hiding issues in
> > cisco os 6.3.4 but it should not result in the connection getting
> > dropped, it also does not explain why this problem does not seam to
> > exists on kernels prior to 2.6.9.
> 
> 2.6.9? This rings a bell.. ;)
> 
> Does disabling TCP window scaling fix it?
> 
> echo 0 > /proc/sys/net/ipv4/tcp_window_scaling

Yes it does solve it. 

Thanks so much - this will be much easier than getting the largest ISP
in Denmark to update there Cisco to a new version.


Regards.

Lars Roland
