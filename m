Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318381AbSGYJnV>; Thu, 25 Jul 2002 05:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318388AbSGYJnV>; Thu, 25 Jul 2002 05:43:21 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:24570 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318382AbSGYJnU>; Thu, 25 Jul 2002 05:43:20 -0400
Subject: Re: Linux-2.4.18-rc3-ac3: bug with using whole disks as filesystems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Luyer <david@luyer.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <004901c233b9$680612b0$638317d2@pacific.net.au>
References: <004901c233b9$680612b0$638317d2@pacific.net.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 25 Jul 2002 11:59:59 +0100
Message-Id: <1027594799.9488.35.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-25 at 09:58, David Luyer wrote:
> Original commands to cause failure:
>   mkfs -b 8192 /dev/sdb -f
>   mount /dev/sdb /cache

That isnt supported on x86 (it exceeds page size) but the crash is
something that should not have happened and points to a missing
validation check in the reiserfs code.

Alan

