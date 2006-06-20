Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbWFTUHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWFTUHh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 16:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWFTUHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 16:07:37 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:12703 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750852AbWFTUHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 16:07:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EAuwyAa5QSQz73AKrJW1+HJVOlLDk7eb9d8pw6WlmBR7btRjQoaQzM0QbvJx+hMYHumJF4tCqGs28Sw1ZBbtOs7UwndxhiMg8SlqlOplrJg3QyOWP0WNsl1kIpC06oD1XUKesuuyEw54+wgXnxkjJK/cR+NHKg1eaYwERJFRgq0=
Message-ID: <7f45d9390606201307yfdb8aadn4d00a6afeba0b09b@mail.gmail.com>
Date: Tue, 20 Jun 2006 14:07:36 -0600
From: "Shaun Jackman" <sjackman@gmail.com>
Reply-To: "Shaun Jackman" <sjackman@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: TL16C752B DUART: MCR_OUT2 disables interrupts
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The datasheet I have for the TL16C752B labels the MCR_OUT1 bit as
`FIFO Rdy enable' and the MCR_OUT2 bit as `IRQ enable'. The latter bit
concerns me. The 8250.c driver sets MCR_OUT2 by default; however, if
the user space clears MCR_OUT2 (through an ioctl TIOCMSET operation or
similar), it seems to me that interrupts for that UART will stop
working. Can someone confirm my suspicion?

I'd expect that clearing/setting the OUT1 and OUT2 pins from user
space should be an innocuous operation. Disabling interrupts is a
fairly nasty side effect.

Please cc me in your reply. Cheers,
Shaun
