Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312643AbSDSPNA>; Fri, 19 Apr 2002 11:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312680AbSDSPM7>; Fri, 19 Apr 2002 11:12:59 -0400
Received: from ns1.advfn.com ([212.161.99.144]:58898 "EHLO mail.advfn.com")
	by vger.kernel.org with ESMTP id <S312643AbSDSPM6>;
	Fri, 19 Apr 2002 11:12:58 -0400
Message-Id: <200204191512.g3JFCvl18558@mail.advfn.com>
Content-Type: text/plain; charset=US-ASCII
From: Tim Kay <timk@advfn.com>
Reply-To: timk@advfn.com
Organization: Advfn.com
To: linux-kernel@vger.kernel.org
Subject: TCP: Treason uncloaked DoS ??
Date: Fri, 19 Apr 2002 16:15:22 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[posted here because the message itself apparantly only appears with debug 
stuff on.]

Please forgive my igonorance but our cluster of load balanced web servers 
suddenly produced a run of:

TCP: Treason uncloaked! Peer XXX.XXX.XXX.XXX:4968/6666 shrinks window 
2154146057:2154152518. Repaired.

lines in our error logs. I have tracked this down to timer.c and I can see 
sort of what's going on [ please correct me if I'm wrong but I think  a 
client is saying 'send me something - ah but not at the moment because I'm 
not ready to receive - but don't close the connection']. Question is are 
multiple instances of this from multiple IPs a DoS possiblility. I assume 
that the connections are kept open if the client connecting doesn't actually 
go away so surely lots of these ocurring at once would overload a server. I 
have googled this and an occasional instance seems normal and could be down 
to a broken client, but lots from different IP addr's at once??

I'm a bit concerned that maybe someone is warming up for a hit or something.

Thanks

Tim

