Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbTKTPkp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 10:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbTKTPkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 10:40:45 -0500
Received: from sea2-dav43.sea2.hotmail.com ([207.68.164.15]:41989 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261909AbTKTPko
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 10:40:44 -0500
X-Originating-IP: [80.204.235.254]
X-Originating-Email: [pupilla@hotmail.com]
From: "Marco Berizzi" <pupilla@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: ipsec on kernel 2.6.0-test9
Date: Thu, 20 Nov 2003 16:41:31 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1123
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1123
Message-ID: <Sea2-DAV43yDd3OJXsN000001a7@hotmail.com>
X-OriginalArrivalTime: 20 Nov 2003 15:40:43.0301 (UTC) FILETIME=[A86CBD50:01C3AF7C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Me again.
I have downloaded kame-snap kit from
ftp://ftp.kame.net/pub/kame/snap/kame-20031117-freebsd49-snap.tgz ,
untarred and kame/IMPLEMENTATION report this:

...
- Tunnel mode IPComp is not working right.  KAME box can generate
tunnelled
  IPComp packet, however, cannot accept tunneled IPComp packet.
...

Is this the problem?

Marco Berizzi wrote:


> Hello everybody.
> I'm playing with ipsec on linux 2.6.0-test9 + ipsec-tools-0.2.2
> I would like to implement a simple esp-tunnel with ipcomp. This is my
> setkey init file:
>
> /usr/local/sbin/setkey -c <<EOF
> flush;
> spdflush;
> spdadd 10.1.2.0/24 10.1.1.0/24 any -P in ipsec
>     ipcomp/tunnel/172.16.1.247-172.16.1.226/require
>     esp/tunnel/172.16.1.247-172.16.1.226/require;
>
> spdadd 10.1.1.0/24 10.1.2.0/24 any -P out ipsec
>     ipcomp/tunnel/172.16.1.226-172.16.1.247/require
>     esp/tunnel/172.16.1.226-172.16.1.247/require;
> EOF
...
> Am I doing something wrong?  Without ipcomp things are working good.
> My env: Slackware 9.1 gcc 3.2.3 kernel 2.6.0-test9 glibc 2.3.2
> ipsec-tools-0.2.2 (Cocorita=172.16.1.247 K2=172.16.1.226 connected by
> two 3C905 100Mbit/s)
> Any feedback are welcome.
> TIA.
>
> PS: Please cc me. I'm not subscribed to the list
