Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261831AbSJQRXX>; Thu, 17 Oct 2002 13:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261761AbSJQRVs>; Thu, 17 Oct 2002 13:21:48 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:27526 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261753AbSJQRTB>;
	Thu, 17 Oct 2002 13:19:01 -0400
Subject: Re: [PATCHSET] Mobile IPv6 for 2.5.43
To: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Cc: ajtuomin@morphine.tml.hut.fi, davem@redhat.com, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       netdev-bounce@oss.sgi.com, pekkas@netcore.fi, torvalds@transmeta.com,
       "Venkata Jagana" <jagana@us.ibm.com>, yoshfuji@linux-ipv6.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF817FBE23.BF8717DA-ON88256C55.005F5EFB@boulder.ibm.com>
From: "Krishna Kumar" <kumarkr@us.ibm.com>
Date: Thu, 17 Oct 2002 10:22:21 -0700
X-MIMETrack: Serialize by Router on D03NM801/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 10/17/2002 11:23:55 AM
MIME-Version: 1.0
Content-type: text/plain; charset=iso-2022-jp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > http://www.mipl.mediapoli.com/patches/mipv6_cn_support.patch
> > http://www.mipl.mediapoli.com/patches/mipv6_mn_support.patch
> > http://www.mipl.mediapoli.com/patches/mipv6_ha_support.patch
>
> Well, I can't find them. I hope they'll be available when I wake up
> tomorrow...

Just replace "_" with "-".

- KK




                                                                                                                                          
                      YOSHIFUJI Hideaki                                                                                                   
                      / 吉藤英明               To:       ajtuomin@morphine.tml.hut.fi                                                     
                      <yoshfuji@linux-i        cc:       davem@redhat.com, kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com,                      
                      pv6.org>                  linux-kernel@vger.kernel.org, pekkas@netcore.fi, torvalds@transmeta.com, Venkata          
                      Sent by:                  Jagana/Beaverton/IBM@IBMUS, yoshfuji@linux-ipv6.org                                       
                      netdev-bounce@oss        Subject:  Re: [PATCHSET] Mobile IPv6 for 2.5.43                                            
                      .sgi.com                                                                                                            
                                                                                                                                          
                                                                                                                                          
                      10/17/2002 10:18                                                                                                    
                      AM                                                                                                                  
                                                                                                                                          
                                                                                                                                          



In article <20021017162624.GC16370@morphine.tml.hut.fi> (at Thu, 17 Oct
2002 19:26:25 +0300), Antti Tuominen <ajtuomin@morphine.tml.hut.fi> says:

> The patch has been split for easier reading as follows:
>
> ipv6_tunnel.patch            6over6 tunneling
> network_mods.patch           Modifications to network code and hooks

Several comments.

[ipv6_tunnel]

I think this is almost ok.

  1. I believe s/ARPHRD_IPV6_IPV6_TUNNEL/ARPHRD_TUNNEL6/.
  2. Please put outer address to hardware address in dev.
     Note: you need to modify SIOxxx ioctls too not to overrun!

[network_mods etc.]

  1. Too many hooks,
     and many duplicate codes in ipv6 stack and mipv6 stack.
     (prefix handler, header parser, ndisc handler etc...)

more comment will come later...


> http://www.mipl.mediapoli.com/patches/mipv6_cn_support.patch
> http://www.mipl.mediapoli.com/patches/mipv6_mn_support.patch
> http://www.mipl.mediapoli.com/patches/mipv6_ha_support.patch

Well, I can't find them. I hope they'll be available when I wake up
tomorrow...

--
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA







