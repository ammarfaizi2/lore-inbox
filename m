Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129935AbQJZXQc>; Thu, 26 Oct 2000 19:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130132AbQJZXQV>; Thu, 26 Oct 2000 19:16:21 -0400
Received: from quattro.sventech.com ([205.252.248.110]:7 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S129935AbQJZXQO>; Thu, 26 Oct 2000 19:16:14 -0400
Date: Thu, 26 Oct 2000 19:01:26 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>, linus@goop.org
Subject: Re: [PATCH] address-space identification for /proc
Message-ID: <20001026190126.E28472@sventech.com>
In-Reply-To: <20001026154527.A30463@goop.org> <20001026155225.B30463@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <20001026155225.B30463@goop.org>; from Jeremy Fitzhardinge on Thu, Oct 26, 2000 at 03:52:25PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2000, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> On Thu, Oct 26, 2000 at 03:45:27PM -0700, I wrote:
> > +	buffer += sprintf("ASID: %p\n", mm);
> 
> Obviously, this should be:
> 
> +	buffer += sprintf("ASID:\t%p\n", mm);

and even more obvious:

+	buffer += sprintf(buffer, "ASID:\t%p\n", mm);

Actually putting it into the buffer would be useful as well :)

JE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
