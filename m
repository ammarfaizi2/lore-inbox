Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271594AbRHUI3c>; Tue, 21 Aug 2001 04:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271597AbRHUI3V>; Tue, 21 Aug 2001 04:29:21 -0400
Received: from newmail.scs.ch ([212.254.229.8]:19588 "EHLO newmail.scs.ch")
	by vger.kernel.org with ESMTP id <S271594AbRHUI3J>;
	Tue, 21 Aug 2001 04:29:09 -0400
Message-ID: <3B821BDD.9743D8A5@scs.ch>
Date: Tue, 21 Aug 2001 10:29:17 +0200
From: Thomas Sailer <sailer@scs.ch>
Reply-To: t.sailer@alumni.ethz.ch
Organization: SCS
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.3-jnxtest i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Patch for bizzare oops in USB
In-Reply-To: <20010818013101.A7058@devserv.devel.redhat.com> <3B80FBA9.556B7B2B@scs.ch> <20010820170614.A28653@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev schrieb:

> Would you mind to explain how a user of usb_control_msg may
> depend on the sleep being interruptible? Forgets to set a timeout?

You may want to be able to kill a process that waits for a control
message to complete. Especially user processes via devio.c, but
quite possibly also user apps via some kernel driver.

devio.c had its own version of usb_control_msg for that reason,
but it was felt unnecessary and removed.

Tom
