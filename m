Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265082AbUGGLk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265082AbUGGLk7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 07:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265083AbUGGLk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 07:40:59 -0400
Received: from chaos.analogic.com ([204.178.40.224]:53892 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265082AbUGGLkz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 07:40:55 -0400
Date: Wed, 7 Jul 2004 07:40:33 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: David Eger <eger@havoc.gtf.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 0xdeadbeef vs 0xdeadbeefL
In-Reply-To: <20040707045202.GA6536@havoc.gtf.org>
Message-ID: <Pine.LNX.4.53.0407070733470.17488@chaos>
References: <20040706215622.GA9505@havoc.gtf.org> <Pine.LNX.4.53.0407062035040.16334@chaos>
 <20040707045202.GA6536@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2004, David Eger wrote:

> On Tue, Jul 06, 2004 at 08:38:53PM -0400, Richard B. Johnson wrote:
> > On Tue, 6 Jul 2004, David Eger wrote:
> >
> > > Is there a reason to add the 'L' to such a 32-bit constant like this?
> > > There doesn't seem a great rhyme to it in the headers...
> >
> > Well if you put the 'name' so we could search for the reason.....
>
> The reason I ask is that I'm going on a cleaning spree of
>
> include/video/radeon.h
>
> I was trying to debug my code figuring out which flags we were
> setting in GMC_GUI_MASTER_CNTL.  Now radeon.h does have lots of
> #defines for what the bits mean, but they're all mixed up, e.g.:
>
> #define GMC_DP_CONVERSION_TEMP_6500                0x00000000
> #define GMC_DP_SRC_RECT                            0x02000000
> #define GMC_DP_SRC_HOST                            0x03000000
> #define GMC_DP_SRC_HOST_BYTEALIGN                  0x04000000

[SNIPPED...]

Yes, they are not pretty. I would suggest puting them in
order, but nothing else. As you can tell by the response,
you have tripped on a hornet's nest and they are attacking
anything in the area. I certainly would not remove 'L' from
any of those constants. The code will be exactly the same
when compiled, but there may be some diagnostic messages
and nasty-grams from kernel hackers.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


