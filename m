Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130018AbRBUNMh>; Wed, 21 Feb 2001 08:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130017AbRBUNMS>; Wed, 21 Feb 2001 08:12:18 -0500
Received: from [63.95.87.168] ([63.95.87.168]:51980 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S129665AbRBUNME>;
	Wed, 21 Feb 2001 08:12:04 -0500
Date: Wed, 21 Feb 2001 08:12:02 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: Ookhoi <ookhoi@dds.nl>
Cc: Vibol Hou <vibol@khmer.cc>, Linux-Kernel <linux-kernel@vger.kernel.org>,
        sim@stormix.com
Subject: Re: 2.4 tcp very slow under certain circumstances (Re: netdev issues (3c905B))
Message-ID: <20010221081202.C4447@xi.linuxpower.cx>
In-Reply-To: <HDEBKHLDKIDOBMHPKDDKMEGDEFAA.vibol@khmer.cc> <20010221104723.C1714@humilis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <20010221104723.C1714@humilis>; from ookhoi@dds.nl on Wed, Feb 21, 2001 at 10:47:24AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2001 at 10:47:24AM +0100, Ookhoi wrote:
[snip]
> We have exactly the same problem but in our case it depends on the
> following three conditions: 1, kernel 2.4 (2.2 is fine), 2, windows ip
> header compression turned on, 3, a free internet access provider in
> Holland called 'Wish' (which seemes to stand for 'I Wish I had a faster
> connection').
> If we remove one of the three conditions, the connection is oke. It is
> only tcp which is affected.
> A packet on its way from linux server to windows client seems to get
> dropped once and retransmitted. This makes the connection _very_ slow.
[snip]

It's been true for some time now that there are several firewalls, RAS, and
NAT devices that break TCP connections in subtile but horrible ways when they
encounter SACK, timestamps, have header compression enabled, or other
'exotic' features.

Has anyone compiled a list of such bugs so that a test application could be
created?
