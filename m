Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263351AbTJVSVF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 14:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263420AbTJVSVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 14:21:05 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:33971 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S263351AbTJVSVC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 14:21:02 -0400
Date: Thu, 23 Oct 2003 07:14:07 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Test8 suspend fails if laptop lid closed.
In-reply-to: <200310220122.27837.rob@landley.net>
To: rob@landley.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>
Message-id: <1066846447.2406.1.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <200310220122.27837.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of us have seen the same thing under 2.4. I've found a hack
solution for my laptop, but need to investigate more. It certainly looks
like an ACPI problem from here.

Regards,

Nigel

On Wed, 2003-10-22 at 19:22, Rob Landley wrote:
> Interesting.  Suspend to disk (echo -n disk > /sys/power/state) works just 
> fine as long as I keep the laptop open until it powers down.  (I timed it, it 
> takes 35 seconds by the way.  Over half of this is "freeing memory" without 
> the hard drive light actually going...)
> 
> If I close the lid while it's busy suspend, it won't.  It'll almost suspend, 
> but the CPU power will stay on, the fan will stay running, and the backlight 
> will stay on even though the screen is otherwise black.  Only thing to do 
> then is hold the power button down for ten seconds until it fully powers off, 
> then reboot it.
> 
> It works reliably so far if I leave the lid open, and fails reliably with the 
> lid closed before it's actually done suspending.  This is on a thinkpad 
> iSeries 1200 something.  (Serial number starting with 1171 6xu, from which 
> the model number can be googled for if it matters...)
> 
> Any ideas?
> 
> Rob
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

