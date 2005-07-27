Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbVG0Dbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbVG0Dbu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 23:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbVG0Dbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 23:31:50 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:14274 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S262047AbVG0Dbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 23:31:49 -0400
From: Grant Coady <lkml@dodo.com.au>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Weird USB errors on HD
Date: Wed, 27 Jul 2005 13:31:44 +1000
Organization: www.scatter.mine.nu
Reply-To: lkml@dodo.com.au
Message-ID: <rkvde1dchs07uar897vtu2vriv0b3p8q5p@4ax.com>
References: <4s3BX-8X-7@gated-at.bofh.it> <4s66H-2ai-21@gated-at.bofh.it> <4s66H-2ai-19@gated-at.bofh.it> <42E6F2A2.7060405@shaw.ca>
In-Reply-To: <42E6F2A2.7060405@shaw.ca>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2005 20:34:10 -0600, Robert Hancock <hancockr@shaw.ca> wrote:

>Karim Yaghmour wrote:
>> That being said, shouldn't there be a way for the kernel to refuse to
>> use this hd if it's not getting enough power. I don't know enough about
>> USB to say, but isn't there something more elegant that could be done in
>> software?
>
>Not really.. It seems like pretty much a matter of the controller saying 
>  it can supply so much power, the drive says it uses so much power, but 
>one of them is lying and the drive ends up tripping the overcurrent.

The drive itself may shutdown until power cycled.  I sorted this issue 
some months ago with a 2.5" 6GB drive in USB enclosure and the fix was 
hardware, adding bypass capacitors to supply peak HDD current.  Software 
cannot fix that.  No dataloss, just apparent lockup from OS point of view.

Drive fails to work on one laptop with a single USB port, but asking for 
700mA from a 500mA USB port is too much, needs external 5V instead.

Grant.

