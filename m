Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282902AbSAPWyX>; Wed, 16 Jan 2002 17:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284979AbSAPWyO>; Wed, 16 Jan 2002 17:54:14 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:29446 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286395AbSAPWyF>; Wed, 16 Jan 2002 17:54:05 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 16 Jan 2002 15:00:12 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Alexei Podtelezhnikov <apodtele@mccammon.ucsd.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [o(1) sched J0] higher priority smaller timeslices, in fact
In-Reply-To: <Pine.LNX.4.44.0201161412140.3787-100000@chemcca18.ucsd.edu>
Message-ID: <Pine.LNX.4.40.0201161458370.934-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2002, Alexei Podtelezhnikov wrote:

>
> The comment and the actual macros are inconsistent.
> positive number * (19-n) is a decreasing function of n!

# man nice


> + * The higher a process's priority, the bigger timeslices
> + * it gets during one round of execution. But even the lowest
> + * priority process gets MIN_TIMESLICE worth of execution time.
> + */
>
> -#define NICE_TO_TIMESLICE(n)   (MIN_TIMESLICE + \
> -	((MAX_TIMESLICE - MIN_TIMESLICE) * (19 - (n))) / 39)
> +#define NICE_TO_TIMESLICE(n) (MIN_TIMESLICE + \
> +	((MAX_TIMESLICE - MIN_TIMESLICE) * (19-(n))) / 39)
>
> I still suggest a different set as faster and more readable at least to
> me. Just two operations instead of 4!

this seems quite readable to me, it's the equation at page 1 of any know
linear geometry book.




- Davide


