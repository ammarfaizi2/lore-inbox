Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129521AbQLORrV>; Fri, 15 Dec 2000 12:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129525AbQLORrL>; Fri, 15 Dec 2000 12:47:11 -0500
Received: from copper.dcs.qmw.ac.uk ([138.37.88.248]:16143 "EHLO
	copper.dcs.qmw.ac.uk") by vger.kernel.org with ESMTP
	id <S129521AbQLORrE>; Fri, 15 Dec 2000 12:47:04 -0500
Date: Fri, 15 Dec 2000 17:16:18 +0000 (GMT)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: <linux-kernel@vger.kernel.org>
Subject: Re: BOOTP not working in 2.2.18?
In-Reply-To: <Pine.LNX.4.30.0012151216020.895-100000@r2-pc>
Message-ID: <Pine.LNX.4.30.0012151713560.15533-100000@lucy>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK this means you need "ip=::::::bootp" on your command-line. I didn't
spot it documented anywhere :-( and it wasn't obvious the default
behaviour had changed until I browsed patch-2.2.18 rather than the patched
file.

I'd still like the userspace bootpc to do the job though. It just grumbles
"sendto: network is unreachable."

At 12:19 -0000 Matt Bernstein wrote:

>In the file net/ipv4/ipconfig.c is a variable called ic_enabled which is
>initialised to zero and never set anywhere. a check is made and bootp
>isn't run if its not set. Setting it to 1 before the check makes it appear
>to work.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
