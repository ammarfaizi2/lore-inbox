Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277847AbRJIRFy>; Tue, 9 Oct 2001 13:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277843AbRJIRFe>; Tue, 9 Oct 2001 13:05:34 -0400
Received: from c009-h018.c009.snv.cp.net ([209.228.34.131]:24738 "HELO
	c009.snv.cp.net") by vger.kernel.org with SMTP id <S277842AbRJIRFb>;
	Tue, 9 Oct 2001 13:05:31 -0400
X-Sent: 9 Oct 2001 17:05:56 GMT
Date: Tue, 9 Oct 2001 10:07:05 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@desktop>
To: "Trever L. Adams" <trever_adams@yahoo.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: iptables in 2.4.10, 2.4.11pre6 problems
In-Reply-To: <1002646705.2177.9.camel@aurora>
Message-ID: <Pine.LNX.4.33.0110091005540.209-100000@desktop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Oct 2001, Trever L. Adams wrote:

> I am seeing messages such as:
>
> Oct  9 12:52:51 smeagol kernel: Firewall:IN=ppp0 OUT= MAC=
> SRC=64.152.2.36 DST=MY_IP_ADDRESS LEN=52 TOS=0x00 PREC=0x00 TTL=246
> ID=1093 DF PROTO=TCP SPT=80 DPT=33157 WINDOW=34752 RES=0x00 ACK FIN
> URGP=0
>
> In my firewall logs.  I see them for ACK RST as well.  These are valid
> connections.  My rules follow for the most part (a few allowed
> connections to the machine in question have been removed from the
> list).  This often leaves open connections in a half closed state on
> machines behind this firewall.  It also some times kills totally open
> connections and I see packets rejected that should be allowed through.

I see this too.  iptables is refusing packets on locally-initiated TCP
connections when the RELATED,ESTABLISHED rule should be letting them
through.

I mentioned this problem on the netfilter list but my message fell into
a black hole and was apparently beyond the horizon of the developers.

-jwb

