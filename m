Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318468AbSIFJ45>; Fri, 6 Sep 2002 05:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318470AbSIFJ45>; Fri, 6 Sep 2002 05:56:57 -0400
Received: from mail.cyberus.ca ([216.191.240.111]:44229 "EHLO cyberus.ca")
	by vger.kernel.org with ESMTP id <S318468AbSIFJ44>;
	Fri, 6 Sep 2002 05:56:56 -0400
Date: Fri, 6 Sep 2002 05:54:09 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: "David S. Miller" <davem@redhat.com>
cc: <akpm@zip.com.au>, <Martin.Bligh@us.ibm.com>, <tcw@tempest.prismnet.com>,
       <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>, <niv@us.ibm.com>,
       Robert Olsson <Robert.Olsson@data.slu.se>
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
In-Reply-To: <20020906.002253.32989079.davem@redhat.com>
Message-ID: <Pine.GSO.4.30.0209060528390.21835-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Sep 2002, David S. Miller wrote:

>    Mala did some testing on this a couple of weeks back.  It appears that
>    NAPI damaged performance significantly.
>
>    http://www-124.ibm.com/developerworks/opensource/linuxperf/netperf/results/july_02/netperf2.5.25results.htm
>
> Unfortunately it is not listed what e1000 and core NAPI
> patch was used.  Also, not listed, are the RX/TX mitigation
> and ring sizes given to the kernel module upon loading.
>
> Robert can comment on optimal settings
>
> Robert and Jamal can make a more detailed analysis of Mala's
> graphs than I.


I looked at those graphs, but the lack of information makes them useless.
For example there are too many variables to the tests --  what is the
effect the message size? and then look at the socket buffer size, would
you set it to 64K if you are trying to show perfomance numbers? What
other tcp settings are there?
Manfred Spraul about a year back complained about some performance issues
in low load setups (which is what this IBM setup seems to be if you count
the pps to the server); its one of those things that have been low in
the TODO deck.
The issue maybe legit not because NAPI is bad but because it is too good.
I dont have the e1000, but i have some Dlinks giges still in boxes and i
have a two-CPU SMP machine; I'll setup the testing this weekend.
In the case of Manfred, we couldnt reproduce the tests because he had this
odd weird NIC; in this case at least access to the e1000 doesnt require
a visit to the museum.

cheers,
jamal

