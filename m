Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273413AbRIXNzh>; Mon, 24 Sep 2001 09:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273911AbRIXNz1>; Mon, 24 Sep 2001 09:55:27 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:26594 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S273413AbRIXNzL>; Mon, 24 Sep 2001 09:55:11 -0400
Subject: Re: __alloc_pages: 0-order allocation failed
From: Paul Larson <plars@austin.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1001319223.4613.34.camel@plars.austin.ibm.com>
In-Reply-To: <Pine.LNX.4.21.0109240810300.1593-100000@freak.distro.conectiva> 
	<1001319223.4613.34.camel@plars.austin.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12 (Preview Release)
Date: 24 Sep 2001 09:01:33 +0000
Message-Id: <1001322094.4613.45.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just remembered that my sar output file is still around from before
sar got killed, so I thought you might like to see the tail end of -r on
it.  Memory utilization got pretty high before sar got killed, but swap
was still at almost nothing:

07:34:18    kbmemfree kbmemused  %memused kbmemshrd kbbuffers  kbcached kbswpfree kbswpused  %swpused
07:34:19        59620    194728     76.56         0      6052    146688    530136         0      0.00
07:34:20        50572    203776     80.12         0      6052    155736    530136         0      0.00
07:34:21        41488    212860     83.69         0      6052    164820    530136         0      0.00
07:34:22        32484    221864     87.23         0      6056    173820    530136         0      0.00
07:34:23        23372    230976     90.81         0      6064    182924    530136         0      0.00
07:34:24        14012    240336     94.49         0      6072    192276    530136         0      0.00
07:34:25         4980    249368     98.04         0      6080    201300    530136         0      0.00
07:34:26         3876    250472     98.48         0      6088    202468    530136         0      0.00
07:34:27         3664    250684     98.56         0      3324    205444    530136         0      0.00
07:34:28         3560    250788     98.60         0      1248    207624    530136         0      0.00
07:34:29         3764    250584     98.52         0       244    208424    530136         0      0.00
07:34:30         4180    250168     98.36         0       148    209272    529532       604      0.11
07:34:31         4072    250276     98.40         0       100    213304    526196      3940      0.74
07:34:32         3488    250860     98.63         0        96    218204    519968     10168      1.92
Average:       122043    132305     52.02         0      5848     84739    530055        81      0.02

-Paul Larson

On 24 Sep 2001 08:13:42 +0000, Paul Larson wrote:
> I'm getting a lot of this with 2.4.10 also.  At the time, I had KDM
> running, but I was coming into the box over telnet and running the
> latest released version of LTP.  The test it appeared to be on at the
> time was a filesystem test called growfiles.  Nothing else was running
> other than these things and standard system services.  The machine has
> 256 MB of ram, and 512 MB swap.  The order that things got killed in
> were sadc, sar, kdm, X, in.telnetd, xinetd (ouch).
> 
> 
> __alloc_pages: 0-order allocation failed (gfp=0xf0/0) from c012b9b2
> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012b9b2
> VM: killing process xinetd
> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012b9b2
> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012b9b2
> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012b9b2
> 
> Thanks,
> Paul Larson
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


