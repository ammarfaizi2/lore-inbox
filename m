Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264228AbRFODvS>; Thu, 14 Jun 2001 23:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264229AbRFODvI>; Thu, 14 Jun 2001 23:51:08 -0400
Received: from sense-robertk-129.oz.net ([216.39.160.129]:18305 "HELO
	mail.kleemann.org") by vger.kernel.org with SMTP id <S264228AbRFODvA>;
	Thu, 14 Jun 2001 23:51:00 -0400
Date: Thu, 14 Jun 2001 20:50:55 -0700 (PDT)
From: Robert Kleemann <robert@kleemann.org>
X-X-Sender: <robert@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Client receives TCP packets but does not ACK
In-Reply-To: <Pine.LNX.4.33.0106121720310.1152-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0106142028150.1149-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple people have requested a test case.

The problem first showed up in a very large java app.  Since then I
wrote a small perl program to duplicate the behavior of the large app
by sending the same data, in the same order, in the same sized blocks,
from the server to the client.

If you want to test this on your configuration then download the
following two files:
http://www.kleemann.org/crap/clientserver
http://www.kleemann.org/crap/log1e1.txt

Place a copy of the files in the same directory on both the client and
the server and run the program the following way:

[server]$ ./clientserver -s log1e1.txt
listening on port 20001

[client]$ ./clientserver -c serverhostname log1e1.txt

The server will attempt to send the data to the client which then
verifies each byte received.

My client generally stops ack-ing between messages 15 and 25.

Robert.

