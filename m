Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290433AbSBKUxM>; Mon, 11 Feb 2002 15:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290454AbSBKUxG>; Mon, 11 Feb 2002 15:53:06 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:49389 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S290433AbSBKUvt>; Mon, 11 Feb 2002 15:51:49 -0500
From: "Nivedita Singhvi" <nivedita@us.ibm.com>
Importance: Normal
Sensitivity: 
Subject: Re: [DOC PATCH] Re: tcp_keepalive_intvl vs tcp_keepalive_time?
To: Rob Landley <landley@trommello.org>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF1F27EF89.EBD28817-ON88256B5D.00711505@boulder.ibm.com>
Date: Mon, 11 Feb 2002 12:51:43 -0800
X-MIMETrack: Serialize by Router on D03NM035/03/M/IBM(Release 5.0.9 |November 16, 2001) at
 02/11/2002 01:51:44 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> What kind of packets are keepalive packets, by the
> way?  (I don't think the firewall rules are filtering
> them out, but I can't be sure.)

> Rob again. :)

Thanks for correcting the documentation - it was out of date and erroneous.

The keepalive packets are simple tcp segments sent on the connection:

- no data
- ack # is next expected byte
- sequence # is a stale (byte already acked by the other end) one, so that
the
  other end is forced to send an ack in return (as it receives an out of
window
  sequence #).

I cant imagine how a firewall would be filtering them..

thanks,
Nivedita



