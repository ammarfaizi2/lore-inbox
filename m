Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030387AbWHORKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbWHORKr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 13:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbWHORKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 13:10:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:9667 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030387AbWHORKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 13:10:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GrnFiE9Rz/1rwUY6c16HW7115+W9UijR5ZA70avsaWVnyc8Nus3Ew5YkdXNtnzs6DfK1r3eJtAyeQA+6hC6FrHR32frn2KcuSjS3n+Rc8pkaSMi0zvjSSKa5LaMqVd5SdpoiID5b0McsS5ICHJitnBvHxyiaWjKA2fRdXuuGWF8=
Message-ID: <d120d5000608151010m3ee6c33fi4a41b41007b1ff69@mail.gmail.com>
Date: Tue, 15 Aug 2006 13:10:45 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Luke Sharkey" <lukesharkey@hotmail.co.uk>
Subject: Re: Touchpad problems with latest kernels
Cc: andi@rhlx01.fht-esslingen.de, davej@redhat.com, gene.heskett@verizon.net,
       ian.stirling@mauve.plus.com, linux-kernel@vger.kernel.org,
       malattia@linux.it, lista1@comhem.se
In-Reply-To: <BAY114-F2421131E2BFF6216D9A52BFA4F0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d120d5000608141227h7c707686i7db7eabba0e3a3ca@mail.gmail.com>
	 <BAY114-F2421131E2BFF6216D9A52BFA4F0@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/06, Luke Sharkey <lukesharkey@hotmail.co.uk> wrote:
> But the driver was ok for the 2054 kernel.  Can't the driver for my touchpad
> be rolled back to the 2054 driver until this is fixed?

The synaptics driver itself was not changed for many month, it is the
surrounding code that was changed and somehow it interferes with your
box.

>  Right now the
> onscreen pointer is practically unusuable when I so much as open a konqueror
> window.  It frequently freezes on screen for many seconds.  (When I said it
> was jerky, I don't mean that it pings around all over the screen).
>

Does it exibit the same behavior when you switch to text console?

Also, is there programs that poll status of your battery or monitor
box's temperature? How often do they do the polling? Have you updated
any of them recently?

Oh, another one... try booting with "ec_intr=0" on the kernel command
line to disable embedded controller interrupt mode.

And finally, can I mples get a dmesg (or /var/log/messages) of boot
with "i8042.debug=1 log_buf_len=131072" please?

-- 
Dmitry
