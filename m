Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264279AbTFDXME (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 19:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264281AbTFDXMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 19:12:03 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:7281 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264279AbTFDXMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 19:12:02 -0400
Message-ID: <3EDE7FEB.2C7FAEC7@digeo.com>
Date: Wed, 04 Jun 2003 16:25:31 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.70-mm3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@redhat.com>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-bk+ broken networking
References: <20030604161437.2b4d3a79.shemminger@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jun 2003 23:25:32.0670 (UTC) FILETIME=[97F8F9E0:01C32AF0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> 
> Test machine running 2.5.70-bk latest can't boot because eth2 won't
> come up.  The same machine and configuration successfully brings up
> all the devices and runs on 2.5.70.

kjournald is stuck waiting for IO to complete against some buffer
during transaction commit.

I'd be suspecting block layer or device drivers.  What device driver
is handling your /var/log?
