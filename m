Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129532AbRA2SvH>; Mon, 29 Jan 2001 13:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131566AbRA2Su5>; Mon, 29 Jan 2001 13:50:57 -0500
Received: from palrel1.hp.com ([156.153.255.242]:24837 "HELO palrel1.hp.com")
	by vger.kernel.org with SMTP id <S129532AbRA2Suy>;
	Mon, 29 Jan 2001 13:50:54 -0500
Message-ID: <3A75BB81.3423F1B2@cup.hp.com>
Date: Mon, 29 Jan 2001 10:50:41 -0800
From: Rick Jones <raj@cup.hp.com>
Organization: the Unofficial HP
X-Mailer: Mozilla 4.75 [en] (X11; U; HP-UX B.11.00 9000/785)
X-Accept-Language: en
MIME-Version: 1.0
To: jamal <hadi@cyberus.ca>
Cc: Andrew Morton <andrewm@uow.edu.au>, lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <Pine.GSO.4.30.0101270729270.24088-100000@shell.cyberus.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll give this a shot later. Can you try with the sendfiled-ttcp?
> http://www.cyberus.ca/~hadi/ttcp-sf.tar.gz

I guess I need to "leverage" some bits for netperf :)


WRT getting data with links that cannot saturate a system, having
something akin to the netperf service demand measure can help. Nothing
terribly fancy - simply a conversion of the CPU utilization and
throughput to a microseconds of CPU to transfer a KB of data. 

As for CKO and avoiding copies and such, if past experience is any guide
(ftp://ftp.cup.hp.com/dist/networking/briefs/copyavoid.ps) you get a
very nice synergistic effect once the last "access" of data is removed.
CKO gets you say 10%, avoiding the copy gets you say 10%, but doing both
at the same time gets you 30%.

rick jones
http://www.netperf.org/
-- 
ftp://ftp.cup.hp.com/dist/networking/misc/rachel/
these opinions are mine, all mine; HP might not want them anyway... :)
feel free to email, OR post, but please do NOT do BOTH...
my email address is raj in the cup.hp.com domain...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
