Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261570AbTCTP61>; Thu, 20 Mar 2003 10:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261575AbTCTP61>; Thu, 20 Mar 2003 10:58:27 -0500
Received: from copper.ftech.net ([212.32.16.118]:40150 "EHLO relay5.ftech.net")
	by vger.kernel.org with ESMTP id <S261570AbTCTP6Z>;
	Thu, 20 Mar 2003 10:58:25 -0500
Message-ID: <7C078C66B7752B438B88E11E5E20E72E0EF765@GENERAL.farsite.co.uk>
From: Kevin Curtis <kevin.curtis@farsite.co.uk>
To: "'bert hubert'" <ahu@ds9a.nl>, "Filipau, Ihar" <ifilipau@sussdd.de>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: read() & close()
Date: Thu, 20 Mar 2003 16:09:20 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I have come across this problem when implementing a sockets
interface to our X.25 card.  On the thread that wants to close the socket,
it must first issue a shutdown().  This will unblock the read() or poll().
And then you can do the close().  


Kevin

-----Original Message-----
From: bert hubert [mailto:ahu@ds9a.nl]
Sent: 20 March 2003 15:08
To: Filipau, Ihar
Cc: 'linux-kernel@vger.kernel.org'
Subject: Re: read() & close()


On Thu, Mar 20, 2003 at 03:14:52PM +0100, Filipau, Ihar wrote:

>     I have/had a simple issue with multi-threaded programs:
> 
>     one thread is doing blocking read(fd) or poll({fd}) on 
>     file/socket.

You can't do poll on a file, it won't tell you anything useful, so I assume
you mean a socket.

>     another thread is doing close(fd).
> 
>     I expected first thread will unblock with some kind 
>     of error - but nope! It is blocked!

Can you show code with this problem?

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
http://netherlabs.nl                         Consulting
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
