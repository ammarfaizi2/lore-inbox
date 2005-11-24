Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbVKXPDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbVKXPDh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 10:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbVKXPDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 10:03:37 -0500
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:32133 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1751363AbVKXPDg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 10:03:36 -0500
Message-ID: <4385D63C.50009@rtr.ca>
Date: Thu, 24 Nov 2005 10:03:24 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       =?ISO-8859-1?Q?Gustavo_Guil?= =?ISO-8859-1?Q?lermo_P=E9rez?= 
	<gustavo@compunauta.com>,
       linux-usb-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: /dev/sr0 not ready, but working
References: <200511221143.00970.gustavo@compunauta.com> <Pine.LNX.4.44L0.0511221349360.21136-100000@iolanthe.rowland.org> <20051122190005.GC6592@havoc.gtf.org>
In-Reply-To: <20051122190005.GC6592@havoc.gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> On Tue, Nov 22, 2005 at 01:56:39PM -0500, Alan Stern wrote:
..
>>Or maybe not...  Maybe the drive _does_ send those "not ready" messages 
>>and the IDE driver ignores them instead of printing them in the system 
>>log.  Or perhaps those messages are sent by the bus interface controller 
>>and not by the drive itself.  I just don't know.
> 
> 
> The difference is between ide-cd.c and sr.c, most likely.

Agreed.  I get hundreds and hundreds of these when simply playing a DVD:

sr0: CDROM not ready.  Make sure there is a disc in the drive.

Nothing really wrong here, other than that the kernel is flooding
my syslogs with messages that could really be left to the userspace
application to decide about.

Cheers
