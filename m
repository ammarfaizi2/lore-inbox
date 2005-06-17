Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbVFQNd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbVFQNd4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 09:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVFQNdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 09:33:55 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:12181
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261967AbVFQNdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 09:33:16 -0400
Reply-To: <abonilla@linuxwireless.org>
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: "'Lars Roland'" <lroland@gmail.com>, <Valdis.Kletnieks@vt.edu>
Cc: "'Alejandro Bonilla'" <abonilla@linuxwireless.org>,
       "'Christian Kujau'" <evil@g-house.de>,
       "'Linux-Kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: tg3 in 2.6.12-rc6 and Cisco PIX SMTP fixup
Date: Fri, 17 Jun 2005 07:33:05 -0600
Message-ID: <001f01c57341$1802c3b0$600cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <4ad99e05050617061864f286a2@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > >
> > > On 6/17/05, Alejandro Bonilla <abonilla@linuxwireless.org> wrote:
> > > > one question,
> > > >
> > > >     Can I know what is the problem?
> > > >:I have 2 tg3 adapters, lots e100's and some Cisco PIX
> and devices.
> > > >
> > > > I can try to reproduce it and see if anyone has
> something to say about it.
> > >
> > > Yes please. As I see it. Enable smtp fixup protocol on
> your cisco pix
> > > (you will need to have a smtp server to point it to), then on some
> > > linux system running with a kernel greater than 2.6.8.1
> do a telnet to
> > > the smtp server that is firewalled and try to issue a
> smtp command.
> > >
> > > Note that cisco has a bug report on smtp fixup banner
> hiding issues in
> > > cisco os 6.3.4 but it should not result in the connection getting
> > > dropped, it also does not explain why this problem does
> not seam to
> > > exists on kernels prior to 2.6.9.
> >
> > 2.6.9? This rings a bell.. ;)
> >
> > Does disabling TCP window scaling fix it?
> >
> > echo 0 > /proc/sys/net/ipv4/tcp_window_scaling
>
> Yes it does solve it.
>
> Thanks so much - this will be much easier than getting the largest ISP
> in Denmark to update there Cisco to a new version.
>
>
> Regards.
>
> Lars Roland

Lars, Valdis,

	So what do we really have here? Problem with Cisco or a problem in the
driver? Both?

.Alejandro

