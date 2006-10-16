Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbWJPK5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbWJPK5u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 06:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWJPK5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 06:57:50 -0400
Received: from 120.eimlf01.mxsweep.com ([82.195.154.120]:22026 "EHLO
	red.mxsweep.com") by vger.kernel.org with ESMTP id S1751498AbWJPK5t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 06:57:49 -0400
Message-ID: <45336569.5040108@draigBrady.com>
Date: Mon, 16 Oct 2006 11:56:41 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joan Raventos <jraventos@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: poll problem with PF_PACKET when using PACKET_RX_RING
References: <20061014214328.25873.qmail@web50614.mail.yahoo.com>
In-Reply-To: <20061014214328.25873.qmail@web50614.mail.yahoo.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Mlf-Version: 5.0.0.8233
X-Mlf-UniqueId: o200610161058370150973
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joan Raventos wrote:
> Hello,
>
> In order to use PF_PACKET/SOCK_RAW with PACKET_RX_RING
> one would possibly do (as described in
> Documentation/networking/packet_mmap.txt):
> 1. setup PF_PACKET socket via socket call.
> 2. use setsockopt to change the PF_PACKET socket into
> PACKET_RX_RING mode and alloc the ring.
> 3. mmap the ring.
> 4. use poll with the socket descriptor and then
> directly access the pkts from the mmaped ring.

A few years back I developed a network sniffer
on 2.4.20 using PACKET_MMAP supporting very high packet rates.
When testing with high packet rates, invariably if traffic
was present while the buffers were being setup, the buffer data
would be corrupted. I worked around it by ensuring no packets went
into the stack before the userspace process sniffing the packets was started.

Pádraig.
