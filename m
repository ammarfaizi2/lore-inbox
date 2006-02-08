Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161067AbWBHIYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161067AbWBHIYI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 03:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161070AbWBHIYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 03:24:08 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:47045 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161067AbWBHIYH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 03:24:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gQy1eIony00q0CltzWQ2xZNXOhAbz1EtId528jYUz7a7owOtcnRTzkwQkzMSNskqxIw3aLeFhhg7IZIySMhO75hxC0SI4auF1hjTFtjbvDbLhmUTNoGEYJxdmpUSINnJ6dE0EJvLIN39+LkkQCIwkOdWBdt3QuWS4Yv7cP+BACo=
Message-ID: <b2fa632f0602080024r61bf1dbfr8bff6ae6a1860562@mail.gmail.com>
Date: Wed, 8 Feb 2006 13:54:06 +0530
From: Raj <inguva@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: /proc/pid/maps keeps growing
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been load testing a server running on RHEL 3.0 (2.4.21). I see that the
/proc/pid/maps keeps growing.

If the server is leaking memory, then i expected, the heap address to
change rather than
creating a new segment. As the server is a threaded app, i tried
ld_preloading my own
library to catch all pthread_create calls, but could catch only 4. So
even threading doesnt
seem to be an issue.

so i am wondering now. I know the server is leaking memory. But i dont
know where to look
 at.

Can someone pls help me in letting me know, in which cases can a
/proc/pid/maps file keep on increasing ?

The server is running on IBM hardware, with 4GB ram. The maps file
currently has 2200
lines just like the ones pasted below.

Please Cc on the replies. Thanks very much for the help.


----------------Last 30 lines of the maps file----------------------
be400000-be5fe000 rw-p 0002e000 00:00 0
be5fe000-be600000 ---p 00000000 00:00 0
be600000-be6fa000 rw-p 000df000 00:00 0
be6fa000-be700000 ---p 00000000 00:00 0
be700000-bebfd000 rw-p 00095000 00:00 0
bebfd000-bec00000 ---p 00000000 00:00 0
bec00000-becff000 rw-p 00595000 00:00 0
becff000-bed00000 ---p 00100000 00:00 0
bed00000-beefe000 rw-p 00101000 00:00 0
beefe000-bef00000 ---p 00000000 00:00 0
bef00000-beffe000 rw-p 00002000 00:00 0
beffe000-bf000000 ---p 00000000 00:00 0
bf000000-bf0ff000 rw-p 00002000 00:00 0
bf0ff000-bf100000 ---p 00000000 00:00 0
bf100000-bf1fd000 rw-p 00001000 00:00 0
bf1fd000-bf200000 ---p 00000000 00:00 0
bf200000-bf4f9000 rw-p 00003000 00:00 0
bf4f9000-bf500000 ---p 00000000 00:00 0
bf500000-bf6ff000 rw-p 00007000 00:00 0
bf6ff000-bf700000 ---p 00000000 00:00 0
bf700000-bf7fc000 rw-p 000c7000 00:00 0
------------------------End--------------------------------
