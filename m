Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbVJFRbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbVJFRbB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 13:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbVJFRbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 13:31:00 -0400
Received: from xproxy.gmail.com ([66.249.82.192]:29986 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751251AbVJFRa7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 13:30:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XBYs1A+cdGsMLGWZPR2pF8C9Ze8EBarISFm5WyL0FyhRk6f/gumSwXJ3lWky9RKsV4xwTf8PjMIEIVtkJ4VEWCrRfTV3sIJHZkRQ0kfVkQ30T3KH5pEb2X3IOPjSb8I9N3smGyoMf5CubZakOuMvaruceten0SPsDLQbEOisCdU=
Message-ID: <b6c5339f0510061030u2e8b0867w455a51da4ca9f2f@mail.gmail.com>
Date: Thu, 6 Oct 2005 13:30:59 -0400
From: Bob Copeland <email@bobcopeland.com>
Reply-To: Bob Copeland <email@bobcopeland.com>
To: Christopher Friesen <cfriesen@nortel.com>
Subject: Re: select(0,NULL,NULL,NULL,&t1) used for delay
Cc: Alex Riesen <raa.lkml@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <43454238.4040907@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1128606546.14385.26.camel@penguin.madhu>
	 <81b0412b0510060727h35c0fd78i260037ca89f253f9@mail.gmail.com>
	 <43454238.4040907@nortel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The select() man page explicitly mentions this usage;
>
> "Some code calls select with all three sets empty, n zero, and a
> non-null timeout as a fairly portable way to sleep with subsecond
> precision."

Perl's documentation also notes it as one of the many ways to do a
subsecond sleep:

>You can effect a sleep of 250 milliseconds this way:
>
>                  select(undef, undef, undef, 0.25);

TMTOWTDI.
