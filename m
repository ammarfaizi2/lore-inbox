Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbWJXKUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWJXKUU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 06:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbWJXKUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 06:20:20 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:37336 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1030270AbWJXKUS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 06:20:18 -0400
Message-ID: <453DE80E.8090607@aitel.hist.no>
Date: Tue, 24 Oct 2006 12:16:46 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: "Christopher \"Monty\" Montgomery" <xiphmont@gmail.com>
CC: Alan Stern <stern@rowland.harvard.edu>,
       Paolo Ornati <ornati@fastwebnet.it>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.19-rc1-mm1 - locks when using "dd bs=1M"
 from card reader
References: <4538B689.2020909@aitel.hist.no>	 <Pine.LNX.4.44L0.0610201133110.7060-100000@iolanthe.rowland.org> <806dafc20610231336s58d64ad8s3bf47b922601ca38@mail.gmail.com>
In-Reply-To: <806dafc20610231336s58d64ad8s3bf47b922601ca38@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------030708040400090404080301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030708040400090404080301
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Christopher "Monty" Montgomery wrote:
> On 10/20/06, Alan Stern <stern@rowland.harvard.edu> wrote:
>> At this point it's beyond me.  Monty will have to take it from here.
>
> I will look more closely at what might have changed there.  Despite
> the code refactoring (and a hand-resolved patch collision at that
> point) the async disable handling *should* have been functionally
> unchanged from 2.6.18.  I will revisit that closely.
>
> Has it actually been demonstrated that this does not crash 2.6.18
> (pre-my-patches) kernels?
I just tested this. 2.6.18 does not crash. I still get tons of errors,
and no data. Copying using 1MB chunks or 4kB chunks
don't matter, it doesn't work.  So card, reader or driver must be faulty.
The card works in a windows machine though.

2.6.19-rc1 gets data with 4kB chunks, and BUGs with 1M chunks.
> If it crashes earlier, that doesn't mean
> I'm uninterested in fixing it, I just want to know.  I don't think
> that had been explicitly answered earlier in the thread.
2.6.18 wasn't tried before, the reason being I did not have this
card reader when 2.6.18 was current.

dmesg output for 2.6.18 (after the dd attempts) is attached.  I have
edited out stuff that isn't usb or scsi.

Helge Hafting


--------------030708040400090404080301
Content-Type: application/gzip;
 name="dmesg3.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dmesg3.gz"

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
--------------030708040400090404080301--
