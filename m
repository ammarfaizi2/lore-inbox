Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbVLPJI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbVLPJI3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 04:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbVLPJI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 04:08:29 -0500
Received: from web35007.mail.mud.yahoo.com ([209.191.68.201]:40830 "HELO
	web35007.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932195AbVLPJI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 04:08:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.br;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=AMbQkgGzlKvOlD+ZCMOSIR8VclFkSdZEbV5K3QjaEt5ZIixohrfKhiZjvc8wnbM+Y69T8/VDRY4kfrOG8OVg0ARprr6MiAWhnqFNzpGDiROa5JQI9uVGOVm3xTV4GSOVrsEpwM46eN/RxKkcHkyji2zNTjjz5OnGn/QNANZRsVI=  ;
Message-ID: <20051216090826.10626.qmail@web35007.mail.mud.yahoo.com>
Date: Fri, 16 Dec 2005 09:08:26 +0000 (GMT)
From: =?iso-8859-1?q?Jos=E9=20Toneh?= <tohnehn@yahoo.com.br>
Subject: wrong SWAP values in top's output
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm running Debian Sarge's stock 2.6 kernel here:

$ uname -a
Linux localhost 2.6.8-2-k7 #1 Thu May 19 18:03:29 JST 2005 i686 GNU/Linux

$ vmstat -s | grep -1 'used swap'
       799992  total swap
       463680  used swap
       336312  free swap

$ top -bn1 | awk 'NR > 6 && NR < 20 { t += $4; print }
> END { print "Total SWAP for the first 12 processes: " t "m" }'
  PID %MEM  VIRT SWAP  RES CODE DATA  SHR nFLT nDRT S PR  NI %CPU COMMAND      
18551 14.1  345m 273m  71m 1712 343m 101m 1373    0 S 5 -10  4.0 XFree86      
25397 49.5  505m 255m 249m  164 505m  40m 3700    0 S 15   0  2.0 mozilla-bin  
24759  0.5  236m 234m 2416   16 236m  54m  138    0 S 17   0  0.0 java_vm      
 3107  4.6  113m  89m  23m  164 112m  34m 1462    0 S 15   0  0.0 mozilla-bin  
31064  1.5 65956  57m 7572  568  63m  19m  291    0 S 15   0  0.0 beep-media-  
27359  0.2 51756  49m 1224  124  50m 2424    0    0 S 25   0  0.0 pdnsd        
19098  3.0 45592  29m  15m  960  43m  15m  368    0 S 15   0  0.0 nicotine     
18653  1.9 37656  27m 9684  644  36m  19m  472    0 S 16   0  0.0 nautilus     
16887  1.6 27544  18m 8416  428  26m  14m  146    0 S 15   0  0.0 xchat        
12479  3.1 33560  16m  15m  428  32m  14m  147    0 S 15   0  0.0 xchat        
18615  0.4 17832  15m 1932   52  17m 3572  320    0 S 16   0  0.0 gconfd-2     
18628  0.8 18896  14m 4332  160  18m  17m    6    0 S 16   0  0.0 gnome-setti  
Total SWAP for the first 12 processes: 1076m

Seems like a bug to me.

Regards,

José Toneh




	



	
		
_______________________________________________________ 
Yahoo! doce lar. Faça do Yahoo! sua homepage. 
http://br.yahoo.com/homepageset.html 

