Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268933AbRHGPbj>; Tue, 7 Aug 2001 11:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268838AbRHGPb3>; Tue, 7 Aug 2001 11:31:29 -0400
Received: from [47.129.117.131] ([47.129.117.131]:25235 "HELO
	pcard0ks.ca.nortel.com") by vger.kernel.org with SMTP
	id <S268928AbRHGPbQ>; Tue, 7 Aug 2001 11:31:16 -0400
Message-ID: <3B7009D5.32491B59@nortelnetworks.com>
Date: Tue, 07 Aug 2001 11:31:33 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ramdisk as root filesystem causes eth carrier errors -- SOLVED 
 (interesting issue)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A while back I posted an issue about getting carrier errors on eth1 when using
ramdisk as root filesystem, but it working perfectly when using an nfs-mounted
root filesystem.

Well, it seems that the culprit is the tulip driver.  After replacing it with
the latest and greatest from scyld, the problem seems to have gone away. 
Apparently some of the tulip drivers had issues with reporting full duplex when
the chip was really only at half duplex.

I am still at a loss to explain why the problem only showed up when using a
ramdisk root filesystem, when the identical kernel and an identical nfs-mounted
filesystem worked perfectly.  Anyone have any ideas?

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
