Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbTIXB1c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 21:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbTIXB1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 21:27:32 -0400
Received: from zero.aec.at ([193.170.194.10]:12559 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261242AbTIXB1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 21:27:31 -0400
To: "Ruth Ivimey-Cook" <Ruth.Ivimey-Cook@ivimey.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How are the Promise drivers doing?
From: Andi Kleen <ak@muc.de>
Date: Wed, 24 Sep 2003 03:27:14 +0200
In-Reply-To: <yX7w.79l.13@gated-at.bofh.it> ("Ruth Ivimey-Cook"'s message of
 "Tue, 23 Sep 2003 17:20:14 +0200")
Message-ID: <m3he33c6x9.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <yX7w.79l.13@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ruth Ivimey-Cook" <Ruth.Ivimey-Cook@ivimey.org> writes:

> These days it seems more motherboards that have additional IDE ports use
> Promise chips, with a few using HPT ones. I note the advent of the
> Promise GPL SATA drivers and Jeff's libata. I am also aware that my
> current setup ( Linux 2.4.22 and onboard 20276) does occasionally cause
> me grief, with lost interrupts making me wonder if all is well. I have 2
> Promise 20267 IDE cards available should that be useful.

One big problem with the Promise drivers is that they are not 64bit
clean. Trying them in a 64bit x86-64 kernel fails quickly.
Fixing them is unfortunately a lot of work because of the weird
Windows like programming style in the CAM layer in there.

Also at least some released versions of them had gapping security holes
in the ioctl handlers.

-Andi
