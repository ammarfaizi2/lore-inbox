Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318274AbSHPHrr>; Fri, 16 Aug 2002 03:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318275AbSHPHrr>; Fri, 16 Aug 2002 03:47:47 -0400
Received: from f159.law15.hotmail.com ([64.4.23.159]:40976 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S318274AbSHPHrq>;
	Fri, 16 Aug 2002 03:47:46 -0400
X-Originating-IP: [202.56.162.141]
From: "Misha Alex" <misha_zant@hotmail.com>
To: linux-kernel@vger.kernel.org
Date: Fri, 16 Aug 2002 07:51:37 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F159156pqkw3Wctbnyd0000b29b@hotmail.com>
X-OriginalArrivalTime: 16 Aug 2002 07:51:38.0132 (UTC) FILETIME=[C02A0540:01C244F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,
   1)How do convert C,H,S into bytes.
     How can one read in linux if we know the C,H,S.

      Also i tried the linear addressing linear = c*H*S + h*S +s -1 .But 
linear or linear*512 never gave me the exact byte offset to seek.

I am working in linux and using a hexeditor to seek .How many exact bytes 
should i seek to find out the extended partition.I read the MBR and found 
the exteneded partiton.
00 01 01 00 02 fe 3f 01 3f 00 00 00 43 7d 00 00
80 00 01 02 0b fe bf 7e 82 7d 00 00 3d 26 9c 00
00 00 81 7f 0f fe ff ff bf a3 9c 00 f1 49 c3 01
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


See the third column it is 0f(extended windows).The cylinder is 639(7f81 h)
and sector is 1 .I don't know where to exactly read for the next partiton.
The byte offset for finding out the next partitions.

If i open hda3(Mind you hda3 is an extended partition on hda) with a
hexeditor i get

00 01 81 7f 83 fe ff 7d 3f 00 00 00 00 82 3e 00
00 00 c1 7e 05 fe ff ff 3f 82 3e 00 7e 04 7d 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

.Now the first partition is of type 83 which is linux and the next
extended partition is of type 05(extended) and cylinder894 and sec1.



*************************************
How do i find the next chain of extended partitions.I mean how do i convert 
cylinder 894 ,sec1 and head 0 into absolute bytes so that i can hexdump the 
next partition table for finding out ?
************************************

Thank you,
Misha

_________________________________________________________________
Send and receive Hotmail on your mobile device: http://mobile.msn.com

