Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316838AbSGHLeh>; Mon, 8 Jul 2002 07:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316847AbSGHLeg>; Mon, 8 Jul 2002 07:34:36 -0400
Received: from brmx1.fl.icn.siemens.com ([12.147.96.32]:51401 "EHLO
	brmx1.fl.icn.siemens.com") by vger.kernel.org with ESMTP
	id <S316838AbSGHLef>; Mon, 8 Jul 2002 07:34:35 -0400
Message-ID: <180577A42806D61189D30008C7E632E8793976@boca213a.boca.ssc.siemens.com>
From: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
To: "'Ben Greear'" <greearb@candelatech.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Question concerning ifconfig
Date: Mon, 8 Jul 2002 07:37:08 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the quick response, but in the mean time I figured it out through
trial and error. My driver did not have a set_mac_address method. There must
have been some sort of default method in 2.2

Jack Bloch
Siemens Carrier Networks
e-mail    : jack.bloch@icn.siemens.com
phone     : (561) 923-6550


-----Original Message-----
From: Ben Greear [mailto:greearb@candelatech.com]
Sent: Friday, July 05, 2002 1:20 PM
To: Bloch, Jack
Cc: 'linux-kernel@vger.kernel.org'
Subject: Re: Question concerning ifconfig


Bloch, Jack wrote:
> I am running a Red Hat 7.2 load (Kernel version 2.4.7-10). I am trying to
> enter the following command to change the MAC address on my device.
> 
> ifconfig ifp0 hw ether A2:A5:A5:01:00:00
> 
> ifp0 is my own device which replaces eth0. The system gives me a response
> "SIOCSIFHWADDR : device or resources busy"
> The same exact command works on my 2.2.16 Kernel. Any ideas why the error.
> Please CC me directly in any responses.

ifconfig ifp0 down

first, then it should work.

Ben

> 
> Thanks in advance,  
> 
> Jack Bloch
> Siemens Carrier Networks
> e-mail    : jack.bloch@icn.siemens.com
> phone     : (561) 923-6550
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear

