Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSFELut>; Wed, 5 Jun 2002 07:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315406AbSFELus>; Wed, 5 Jun 2002 07:50:48 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:53242 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S315388AbSFELuk>; Wed, 5 Jun 2002 07:50:40 -0400
Message-ID: <3CFDFAF6.8090801@fokus.fhg.de>
Date: Wed, 05 Jun 2002 13:50:14 +0200
From: Matthias Welk <welk@fokus.gmd.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Matthias Welk <welk@fokus.gmd.de>, linux-kernel@vger.kernel.org
Subject: Re: nfs slowdown since 2.5.4
In-Reply-To: <200206041253.44446.welk@fokus.gmd.de> <200206041848.38954.trond.myklebust@fys.uio.no> <200206041916.29725.welk@fokus.gmd.de> <200206041928.54392.trond.myklebust@fys.uio.no>
Content-Type: multipart/mixed;
 boundary="------------060904040607060900000000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060904040607060900000000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Trond Myklebust wrote:

>On Tuesday 04 June 2002 19:16, Matthias Welk wrote:
>  
>
>>On Tuesday 04 June 2002 18:48, Trond Myklebust wrote:
>>    
>>
>>>On Tuesday 04 June 2002 17:56, Matthias Welk wrote:
>>>      
>>>
>>>>To get more info about this problem I compared the compile time and the
>>>>nfs traffic between 2.4.18-4 and 2.5.20 on a RedHat 7.3 system.
>>>>The sources (mosfet-liquid0.9.5.tar.gz - KDE style) were located on the
>>>>local disc and the libraries were linked over nfs.
>>>>The results attached to this mail show the big difference !
>>>>        
>>>>
>
>Does the appended patch make a difference
>

Yes, the lookup rate increased 1/3 compared to the unpatched version.
I have attached updated results of the build process, because there was a
mistake for the 2.4.18 version.

Now the addition to my last mail:

NFS-Server:        Auspex NS3010
NFS-Filesystem:    Auspex-specific (FastFLO Journaling File System)

Greetings, Matthias
---------------------------------------------------------------
From: Matthias Welk                   office:  +49-30-3463-7272
      FHG Fokus                       mobile:  +49-179- 1144752
      Kaiserin-Augusta-Allee 31       fax   :  +49-30-3463-8672
      10589 Berlin                    email : welk@fokus.fhg.de
----------------------------------------------------------------


--------------060904040607060900000000
Content-Type: text/plain;
 name="build_2.4.18.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="build_2.4.18.txt"

#time to build on a RedHat 7.3 system with 2.4.18-4

real	1m8.473s
user	0m51.510s
sys	0m7.800s

# packets:	7757
lookup:		2952
getattr:	175
readdir:	72
readlink:	119
read:		567
frag:		4144
other:		0

--------------060904040607060900000000
Content-Type: text/plain;
 name="build_2.5.20.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="build_2.5.20.txt"

#time to build on a RedHat 7.3 system with 2.5.20

real    1m48.509s
user    0m51.320s
sys     0m12.790s

# packets:	149859
lookup:		143791
getattr:	1273
readdir:	24
readlink:	119
read:		828
frag:		4232
other:		0

--------------060904040607060900000000
Content-Type: text/plain;
 name="build_2.5.20_patched.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="build_2.5.20_patched.txt"

#time to build on a RedHat 7.3 system with 2.5.20 patched

real    2m11.262s
user    0m50.960s
sys     0m14.260s

# packets:	234552
lookup:		229030
getattr:	728
readdir:	24
readlink:	119
read:		827
frag:		4231
other:		0

--------------060904040607060900000000--

