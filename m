Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTJVS3x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 14:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263498AbTJVS3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 14:29:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:30432 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263496AbTJVS3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 14:29:51 -0400
Date: Wed, 22 Oct 2003 11:30:28 -0700
From: Dave Olien <dmo@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: rwhron@earthlink.net, venom@sns.it, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Mary Edie Meredith <maryedie@osdl.org>
Subject: Re: [BENCHMARK] I/O regression after 2.6.0-test5
Message-ID: <20031022183028.GA10249@osdl.org>
References: <20031021130501.GA4409@rushmore> <3F9653E6.4060209@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F9653E6.4060209@cyberone.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry, this patch didn't fix our performance problems.  Mary just
finished running dbt2 on test8 with your patch:

NOTPM   kernel          scheduler
965     2.6.0-test8-np  AS
1632    2.6.-test6-mm4  deadline

This is an 8-way system with DAC960 and 12 LUNs, using raw devices.
That's still quite a sizeable drop.

On Wed, Oct 22, 2003 at 07:54:46PM +1000, Nick Piggin wrote:
> 
> Could you please try the following patch against 2.6.0-test8.
> Thanks. I'll have to come up with something more comprehensive
> because this destroys find | xargs grep during other IO. It
> looks like this might be the cause of a lot of AS's database
> problems though.
> 
> I'm working on something...
> 
