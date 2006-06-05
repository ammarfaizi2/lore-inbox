Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932430AbWFEG2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWFEG2g (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 02:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWFEG2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 02:28:36 -0400
Received: from wx-out-0102.google.com ([66.249.82.200]:51805 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932430AbWFEG2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 02:28:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=lqSpae63YpB9HprHl6TPqrvynPz/h+o01U3uflRl5wdfWsHyizj3yeAGB4CAheuTM9REXE6pA+LHg9m8IWnPpzrkVS8c7DnFZCVYVXs4Ckdwcgkq2S94Bk2dsPT5l9/zUoPuP/4Y/omdpWyK+OU7H68cOranG3WHlDei/PNICak=
Message-ID: <986ed62e0606042328u60bb05ccode9f47b10f5cb2b1@mail.gmail.com>
Date: Sun, 4 Jun 2006 23:28:34 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm3: "BUG: scheduling while atomic" flood when resuming from disk
Cc: mingo@elte.hu, arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>
In-Reply-To: <20060604225140.cf87519f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <986ed62e0606042223l2381d877g4bc798ec64804d43@mail.gmail.com>
	 <20060604225140.cf87519f.akpm@osdl.org>
X-Google-Sender-Auth: 454426ddceec70bc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/06, Andrew Morton <akpm@osdl.org> wrote:
> On Sun, 4 Jun 2006 22:23:24 -0700
> "Barry K. Nathan" <barryn@pobox.com> wrote:
>
> Please don't send word-wrapped emails.

Hmm... I didn't realize it was getting wrapped. I'll try to avoid that
next time. (If my next attempt to avoid the word-wrapping fails, then
I may not have enough free time to move to a sane mailer again for 2-3
weeks.)

[snip]
> The interesting thing is that we've done sleepy things like down() just
> prior to this.  Do you have CONFIG_PREEMPT and CONFIG_DEBUG_SPINLOCK_SLEEP
> enabled?  If not, please turn them on, see what happens.

PREEMPT is enabled. DEBUG_SPINLOCK_SLEEP isn't. I'll enable it now.
-- 
-Barry K. Nathan <barryn@pobox.com>
