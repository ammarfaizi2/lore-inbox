Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318361AbSIBTCX>; Mon, 2 Sep 2002 15:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318357AbSIBTCX>; Mon, 2 Sep 2002 15:02:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37138 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318355AbSIBTCV>;
	Mon, 2 Sep 2002 15:02:21 -0400
Message-ID: <3D73B6BF.9030200@mandrakesoft.com>
Date: Mon, 02 Sep 2002 15:06:39 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Feldman, Scott" <scott.feldman@intel.com>
CC: linux-kernel@vger.kernel.org, linux-net <linux-net@vger.kernel.org>,
       "'Dave Hansen'" <haveblue@us.ibm.com>,
       "'Manand@us.ibm.com'" <Manand@us.ibm.com>, kuznet@ms2.inr.ac.ru,
       "'David S. Miller'" <davem@redhat.com>,
       "Leech, Christopher" <christopher.leech@intel.com>
Subject: Re: TCP Segmentation Offloading (TSO)
References: <288F9BF66CD9D5118DF400508B68C4460283E564@orsmsx113.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Feldman, Scott wrote:
> TCP Segmentation Offloading (TSO) is enabled[1] in 2.5.33, along with an
> enabled e1000 driver.  Other capable devices can be enabled ala e1000; the
> driver interface (NETIF_F_TSO) is very simple.
> 
> So, fire up you favorite networking performance tool and compare the
> performance gains between 2.5.32 and 2.5.33 using e1000.  I ran a quick test
> on a dual P4 workstation system using the commercial tool Chariot:
> 
> Tx/Rx TCP file send long (bi-directional Rx/Tx)
>   w/o TSO: 1500Mbps, 82% CPU
>   w/  TSO: 1633Mbps, 75% CPU
> 
> Tx TCP file send long (Tx only)
>   w/o TSO: 940Mbps, 40% CPU
>   w/  TSO: 940Mbps, 19% CPU
> 
> A good bump in throughput for the bi-directional test.  The Tx-only test was
> already at wire speed, so the gains are pure CPU savings.
> 
> I'd like to see SPECWeb results w/ and w/o TSO, and any other relevant
> testing.  UDP framentation is not offloaded, so keep testing to TCP.


Are there docs or other drivers about?

8139C+ chip can do TSO, so I would like to implement support.

	Jeff


