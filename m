Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269485AbUJFU6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269485AbUJFU6k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 16:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269394AbUJFU6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:58:33 -0400
Received: from [213.196.40.106] ([213.196.40.106]:60828 "EHLO
	eljakim.netsystem.nl") by vger.kernel.org with ESMTP
	id S269485AbUJFU6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:58:12 -0400
Date: Wed, 6 Oct 2004 22:58:07 +0200 (CEST)
From: Joris van Rantwijk <joris@eljakim.nl>
X-X-Sender: joris@eljakim.netsystem.nl
To: Andries Brouwer <aebr@win.tue.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
In-Reply-To: <20041006203818.GD4523@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.58.0410062243090.11846@eljakim.netsystem.nl>
References: <003301c4abdc$c043f350$b83147ab@amer.cisco.com>
 <41644D86.4010500@nortelnetworks.com> <20041006130615.4f65a920.davem@davemloft.net>
 <4164530F.7020605@nortelnetworks.com> <20041006203818.GD4523@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 6 Oct 2004, Andries Brouwer wrote:
> Does this really happen?

Yes. Finally got my raw-udp-with-wrong-checksum sending program to work
over localhost and it hangs recvfrom pretty good.

> All kernel versions?

Quick guess: probably since late 2.4. Source of 2.4.27 udp.c is similar to
2.6.9, but 2.4.17 returns EAGAIN even for blocking sockets, apparently
this was "fixed" later on.

> Is this the explanation for the reported behaviour?)

Very hard to say since I can't predict when it will occur again.

Joris.
