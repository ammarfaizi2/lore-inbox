Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265019AbTIIXNQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 19:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265040AbTIIXNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 19:13:15 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:905 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S265019AbTIIXNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 19:13:12 -0400
Subject: Re: Efficient IPC mechanism on Linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luca Veraldi <luca.veraldi@katamail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <014201c3771d$4e95c160$36af7450@wssupremo>
References: <00f201c376f8$231d5e00$beae7450@wssupremo>
	 <1063142262.30981.17.camel@dhcp23.swansea.linux.org.uk>
	 <014201c3771d$4e95c160$36af7450@wssupremo>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063149117.31269.24.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Wed, 10 Sep 2003 00:11:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-09-09 at 22:57, Luca Veraldi wrote:
> Also. The central point is not to have10 instead of 50 assembler lines
> in the primitives. The central point is to implement communication
> primitives
> that do not require physical copying of the messages being sent and
> received.

The question (for smaller messages) is whether this is a win or not.
While the data fits in L1 cache the copy is close to free compared
with context switching and TLB overhead

> We have 2 process communicating over a channel in a pipeline fashion.
> A writes some information in a buffer and sends it to B.
> B receives and reads.
> This for 1000 times.
> Times reported are average time.

Ok - from you rexample I couldnt tell if B then touches each byte of
data as well as having it appear in its address space.

