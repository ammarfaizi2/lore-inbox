Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129780AbQLOAd6>; Thu, 14 Dec 2000 19:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130529AbQLOAds>; Thu, 14 Dec 2000 19:33:48 -0500
Received: from Cantor.suse.de ([194.112.123.193]:16648 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129780AbQLOAdf>;
	Thu, 14 Dec 2000 19:33:35 -0500
Date: Fri, 15 Dec 2000 01:03:07 +0100
From: Andi Kleen <ak@suse.de>
To: Adam Scislowicz <adams@fourelle.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Non-Blocking socket (SOCK_STREAM send)
Message-ID: <20001215010307.A26507@gruyere.muc.suse.de>
In-Reply-To: <3A3953DB.CDA2DF4E@fourelle.com> <20001215002032.A24018@gruyere.muc.suse.de> <3A39573D.BB731C8@fourelle.com> <20001215003533.A26106@gruyere.muc.suse.de> <3A395DA8.312BC23@fourelle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A395DA8.312BC23@fourelle.com>; from adams@fourelle.com on Thu, Dec 14, 2000 at 03:54:16PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2000 at 03:54:16PM -0800, Adam Scislowicz wrote:
> > From your subject you seem not to.
> >
> Im sorry for the subject I just wanted to give the environmental factors, and it is a
> non-blocking socket. At this point I am not sure if that is relavent or not.
> 
> > To the best of my knowledge the receiver side EPIPE reporting has not changed,
> > so it must be something in the sender that causes it to close the connection
> > earlier. What you have to find out.
> >
> We simply rerun the same binary in the same environment, first with 2.2.x, and then
> with 2.4.x. We have verified that socket(), and connect() calls are successfull, and
> all of our problems arise when we go to send().
> We do not send() until our main select() loop sets the writeable flag on our socket
> descriptor, so our problem should not be related to a pre-mature send().
> I dont expect this to be a kernel bug, but I was hopeing from the pseudo-code I posted
> to get a "you are doing this wrong" response.

It is hard to be sure with a tcpdump log of the incident. If you send me one I'll look
at it.



-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
