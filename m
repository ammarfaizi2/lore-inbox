Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265931AbUF2StS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265931AbUF2StS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 14:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUF2StS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 14:49:18 -0400
Received: from fmx3.freemail.hu ([195.228.242.223]:10255 "HELO
	fmx3.freemail.hu") by vger.kernel.org with SMTP id S265931AbUF2SsC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 14:48:02 -0400
Date: Tue, 29 Jun 2004 20:47:57 +0200 (CEST)
From: Debi Janos <debi.janos@freemail.hu>
Subject: Re: 2.6.7-mm1 - 2.6.7-mm4 weird http behavior
To: bert hubert <ahu@ds9a.nl>
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040629183847.GA9493@outpost.ds9a.nl>
Message-ID: <freemail.20040529204757.69738@fm12.freemail.hu>
X-Originating-IP: [81.182.188.190]
X-HTTP-User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert <ahu@ds9a.nl> írta:

> On Tue, Jun 29, 2004 at 08:04:46PM +0200, Debi Janos wrote:
> > bert hubert <ahu@ds9a.nl> ?rta:

> Suggestions:
> 	1) turn off timestamps (echo 0 >
/proc/sys/net/ipv4/tcp_timestamps)
> 	2) set your MTU to 1000 or so (ifconfig eth0 mtu 1000)
> 
> And try again.
> 
> Interesting case!

problem workarounded:

sysctl -w net.ipv4.tcp_moderate_rcvbuf=0
sysctl -w net.ipv4.tcp_default_win_scale=0 

Thanks.
