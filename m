Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130755AbRAZOQ5>; Fri, 26 Jan 2001 09:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130816AbRAZOQr>; Fri, 26 Jan 2001 09:16:47 -0500
Received: from linuxcare.com.au ([203.29.91.49]:19475 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S130755AbRAZOQ2>; Fri, 26 Jan 2001 09:16:28 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Sat, 27 Jan 2001 01:12:51 +1100
To: "David S. Miller" <davem@redhat.com>
Cc: Sasi Peter <sape@iq.rulez.org>, linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
Message-ID: <20010127011250.A22310@linuxcare.com>
In-Reply-To: <20010125212033.E14807@linuxcare.com> <Pine.LNX.4.30.0101251157400.5377-100000@iq.rulez.org> <20010126171014.B18463@linuxcare.com> <14961.25502.797308.994383@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <14961.25502.797308.994383@pizda.ninka.net>; from davem@redhat.com on Fri, Jan 26, 2001 at 03:46:38AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Dave,

How are the VB withdrawal symptoms going? :)
 
> Anton, why are you always returning -1 (which means error for the
> smb_message[] array functions) when using sendfile?

Returning -1 tells the higher level code that we actually sent the bytes
out ourselves and not to bother doing it.

> Aren't you supposed to return the number of bytes output or
> something like this?

Only if you want the code to do a send() on outbuf which we dont here.

Cheers,
Anton
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
