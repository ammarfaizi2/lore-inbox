Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbUKSWAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbUKSWAM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUKSVyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 16:54:17 -0500
Received: from c7ns3.center7.com ([216.250.142.14]:12701 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S261605AbUKSVwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 16:52:03 -0500
Message-ID: <419E6E5D.2000709@devicelogics.com>
Date: Fri, 19 Nov 2004 15:06:21 -0700
From: "Jeff V. Merkey" <jmerkey@devicelogics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@devicelogics.com>
Cc: linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: Linux 2.6.9 pktgen module causes INIT process respawning and
 sickness
References: <419E6B44.8050505@devicelogics.com>
In-Reply-To: <419E6B44.8050505@devicelogics.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Additionally, when packets sizes 64, 128, and 256 are selected, pktgen 
is unable to achieve > 500,000 pps (349,000 only on my system).
A Smartbits generator can achieve over 1 million pps with 64 byte 
packets on gigabit.  This is one performance
issue for this app.  However, at 1500 and 1048 sizes, gigabit saturation 
is achievable. 

Jeff

Jeff V. Merkey wrote:

>
> With pktgen.o configured to send 123MB/S on a gigabit on a system 
> using pktgen set to the following parms:
>
> pgset "odev eth1"
> pgset "pkt_size 1500"
> pgset "count 0"
> pgset "ipg 5000"
> pgset "src_min 10.0.0.1"
> pgset "src_max 10.0.0.254"
> pgset "dst_min 192.168.0.1"
> pgset "dst_max 192.168.0.254"
>
> After 37 hours of continual packet generation into a gigabit 
> regeneration tap device,
> the server system console will start to respawn the INIT process about 
> every 10-12
> hours of continuous packet generation.
>
> As a side note, this module in Linux is extremely useful and the "USE 
> WITH CAUTION" warnings
> are certainly will stated.  The performance of this tool is excellent.
>
> Jeff
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

