Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313639AbSDZR4g>; Fri, 26 Apr 2002 13:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314099AbSDZR4f>; Fri, 26 Apr 2002 13:56:35 -0400
Received: from p5082852B.dip0.t-ipconnect.de ([80.130.133.43]:61058 "EHLO
	leonov.stosberg.net") by vger.kernel.org with ESMTP
	id <S313639AbSDZR4e>; Fri, 26 Apr 2002 13:56:34 -0400
Date: Fri, 26 Apr 2002 19:56:12 +0200
From: Dennis Stosberg <dennis@stosberg.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre7-ac2: Promise Ultra100TX2 broken
Message-ID: <20020426175612.GA559@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-ICQ: 63537718
X-PGP-Key: http://stosberg.net/dennis.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, 


In the late 2.4.19-preX-acY the support for the Promise
Ultra100TX2 is broken. This problem was already reported on
lkml and on the German SuSE Linux mailing list. According to
information from that list the problem only affects the
Ultra100TX2, but NOT the Ultra100TX.

The latest -ac kernel I know to work with this controller, is
2.4.19-pre2-ac4. I just tried 2.4.19-pre7-ac2: it
fails. 2.4.19-pre4-ac3 has also been reported to fail:

http://www.ussg.iu.edu/hypermail/linux/kernel/0203.3/1011.html


At boot time 2.4.19-pre7-ac2 prints these error messages. The
drives ARE conntected using an 80-pin cable:

hde: set_drive_speed_status: status=0xff { Busy }
Warning: Primary channel requires an 80-pin cable for operation.
hde reduced to Ultra33 mode.
[..]
end_request: I/O error, dev 21:00 (hde), sector 0
end_request: I/O error, dev 21:00 (hde), sector 2
end_request: I/O error, dev 21:00 (hde), sector 4
end_request: I/O error, dev 21:00 (hde), sector 6
end_request: I/O error, dev 21:00 (hde), sector 0
end_request: I/O error, dev 21:00 (hde), sector 2
end_request: I/O error, dev 21:00 (hde), sector 4
end_request: I/O error, dev 21:00 (hde), sector 6


You can find the configuration of the failing kernel at:

http://stosberg.net/tmp/config-2.4.19-pre7-ac2


Currently I'm using 2.4.19-pre5aa1 without problems.

Regards, 
Dennis

-- 
Dennis Stosberg
  eMail: dennis@stosberg.net
         dstosber@techfak.uni-bielefeld.de
pgp key: http://stosberg.net/dennis.asc
