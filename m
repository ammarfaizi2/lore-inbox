Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132828AbQLOAGf>; Thu, 14 Dec 2000 19:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131370AbQLOAG1>; Thu, 14 Dec 2000 19:06:27 -0500
Received: from Cantor.suse.de ([194.112.123.193]:24838 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132828AbQLOAGF>;
	Thu, 14 Dec 2000 19:06:05 -0500
Date: Fri, 15 Dec 2000 00:35:33 +0100
From: Andi Kleen <ak@suse.de>
To: Adam Scislowicz <adams@fourelle.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Non-Blocking socket (SOCK_STREAM send)
Message-ID: <20001215003533.A26106@gruyere.muc.suse.de>
In-Reply-To: <3A3953DB.CDA2DF4E@fourelle.com> <20001215002032.A24018@gruyere.muc.suse.de> <3A39573D.BB731C8@fourelle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A39573D.BB731C8@fourelle.com>; from adams@fourelle.com on Thu, Dec 14, 2000 at 03:26:53PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2000 at 03:26:53PM -0800, Adam Scislowicz wrote:
> We understand the meaning of EPIPE, the question is why 2.4.x is returning EPIPE,
> while 2.2.x is succeeding in sending
> the data to thttpd. Using the 2.2.x kernel our proxy functions, and I can access
> thttpd directly. In 2.4.x I can access thttpd

>From your subject you seem not to.

To the best of my knowledge the receiver side EPIPE reporting has not changed,
so it must be something in the sender that causes it to close the connection
earlier. What you have to find out.



>  I have already noticed that the 2.4.x kernel does not set errno = 0 in many places
> where the 2.2.x kernel did, so there are
> differences.

No system call ever sets errno = 0. 


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
