Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261342AbRFFJHX>; Wed, 6 Jun 2001 05:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261297AbRFFJHN>; Wed, 6 Jun 2001 05:07:13 -0400
Received: from mail.scs.ch ([212.254.229.5]:3336 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id <S261289AbRFFJHE>;
	Wed, 6 Jun 2001 05:07:04 -0400
Message-ID: <3B1DF17C.124B1135@scs.ch>
Date: Wed, 06 Jun 2001 11:01:48 +0200
From: Thomas Sailer <sailer@scs.ch>
Reply-To: t.sailer@alumni.ethz.ch
Organization: SCS
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jcwren@jcwren.com
CC: linux-kernel@vger.kernel.org
Subject: Re: USBDEVFS_URB_TYPE_INTERRUPT
In-Reply-To: <NDBBKBJHGFJMEMHPOPEGGEICCIAA.jcwren@jcwren.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Chris Wren schrieb:

>         I don't really want to write a full-up kernel mode driver for this device,
> but interrupt type messages are the preferred method for communicating,
> since once a message needs to be sent, it should be timely (whereas control
> messages could be delayed a significant amount on a busy USB channel).

If you critically depend on tight timing you'll need a kernel driver
anyway, as your usermode task might be delayed on a busy machine too.
Otherwise you can use bulk ins timed from userspace

Tom
