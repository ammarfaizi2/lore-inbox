Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265913AbUF2SlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265913AbUF2SlH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 14:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265910AbUF2SlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 14:41:07 -0400
Received: from fmx6.freemail.hu ([195.228.242.226]:48697 "HELO
	fmx6.freemail.hu") by vger.kernel.org with SMTP id S265916AbUF2Sky convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 14:40:54 -0400
Date: Tue, 29 Jun 2004 20:40:51 +0200 (CEST)
From: Debi Janos <debi.janos@freemail.hu>
Subject: Re: 2.6.7-mm1 - 2.6.7-mm4 weird http behavior
To: linux-kernel@vger.kernel.org
Message-ID: <freemail.20040529204051.42768@fm5.freemail.hu>
X-Originating-IP: [81.182.188.190]
X-HTTP-User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger <shemminger@osdl.org> írta:

> Dave enabled the receive buffer auto-tuning which uses TCP
window
> scaling.  It looks like all these sites are running
FreeBSD, perhaps
> there is a bug in FreeBSD?

packages.gentoo.org running on FreeBSD? I don't believe that. 

http://uptime.netcraft.com/up/graph?site=packages.gentoo.org

running on Gentoo Linux,  Apache/2.0.4

My site (www.hup.hu) running on FreeBSD 4.7-RC with Apache
1.3.29

http://uptime.netcraft.com/up/graph?site=www.hup.hu

it was problem with both site

> As suggested earlier please get a TCP dump of a failed
connection.
> 
> To turn of receive buffer auto-tuning:
> 	sysctl -w net.ipv4.tcp_moderate_rcvbuf=0
> 	sysctl -w net.ipv4.tcp_default_win_scale=0
> 
> Thanks.

Yes. This was the problem. With this settings working...
Thank you.
