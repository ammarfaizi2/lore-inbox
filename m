Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264310AbTLaMLb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 07:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264323AbTLaMLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 07:11:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7635 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264310AbTLaML3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 07:11:29 -0500
Message-ID: <3FF2BCDE.5010302@pobox.com>
Date: Wed, 31 Dec 2003 07:11:10 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lennert Buytenhek <buytenh@gnu.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-mm2] e100 driver hangs after period of moderate receive
 load
References: <20031231110209.GA9858@gnu.org>
In-Reply-To: <20031231110209.GA9858@gnu.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennert Buytenhek wrote:
> Hi,
> 
> After banging on an e100 card for about ten minutes with a ~60kpps stream,
> the interface stops receiving packets.  Interrupts come in once every few
> seconds (from /proc/interrupts), but no packets are received anymore at all.
> Lots of slab corruption messages in the syslog that were generated during
> that packet stream (see other email I sent.)  Stopping the packet stream
> still leaves the interface unusable.  'ifconfig eth1 down ; ifconfig eth1 up'
> seems to fix things.


Is NAPI enabled for this driver?  The interrupt behavior seems normal 
for NAPI, but certainly the rest of the behavior does not...

	Jeff



