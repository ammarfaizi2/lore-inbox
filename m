Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279394AbRJ2TaQ>; Mon, 29 Oct 2001 14:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279403AbRJ2TaF>; Mon, 29 Oct 2001 14:30:05 -0500
Received: from [65.192.191.151] ([65.192.191.151]:21005 "EHLO lucy.trebia.com")
	by vger.kernel.org with ESMTP id <S279394AbRJ2T3y>;
	Mon, 29 Oct 2001 14:29:54 -0500
Message-ID: <3BDDADFF.77EB8912@trebia.com>
Date: Mon, 29 Oct 2001 14:29:03 -0500
From: "Ashish A. Palekar" <apalekar@trebia.com>
Organization: Trebia Networks
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: greearb@candelatech.com, nitin.dhingra@dcmtech.co.in,
        linux-kernel@vger.kernel.org
Subject: Re: iSCSI support for Linux
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben/Nitin:

I was going through some of the emails you guys had sent out on the LKML
about iscsi support. I think there is some confusion about the projects.

There are three different projects that I am aware of and are currently
active.

1. Cisco
2. Intel
3. UNH - Chris Loveland and myself were both from UNH and have since
graduated. However, there is still active development work.

As far as the UNH project goes:

We have been working on both the Initiator (host) and the Target
(Server) side. The Initiator side should work directly with the SCSI
Initiator mid-level. As I am given to understand, the code was revved up
to version 6.

On the Target side, the project is a little more elaborate. Since there
is no existing SCSI Target support, we have developed a SCSI Target
Mid-level. This has three front-ends written for it which support:

1. Adaptec's SCSI Encapsulation Protocol (defunct last November - since
iSCSI has become the dominant SAN over TCP/IP protocol)
2. QLogic ISP 2200 A Fibre Channel driver
3. iSCSI driver (and this works on the TCP/IP software stack which Linux
has) - so it is pretty much limited by whatever ethernet cards Linux
supports (including GigE). We did not have access to TCP accelerated
cards so the development on those has not been done.

Thus you have three target drivers written for the SCSI Target mid-level
which we has been written. For the iSCSI driver itself - there are four
target drivers one for rev 0, rev 03, rev 06 and rev 08.

The UNH drivers are available for download from:

http://www.iol.unh.edu/consortiums/fc/fc_linux.html
http://www.iol.unh.edu/consortiums/iscsi

They have been GPLed. Lots of people are currently trying out the code
and letting me and the other developers know about the bugs. Ideally, we
would like to fix those (however, the rev version of the draft keeps on
changing :-(). The Initiator code is fairly straightforward. For how to
use the target code, my thesis is available with the tar ball from one
of these sites.

Okay .. to your question about authentication Ben .. the consideration
we had to make was that a lot of the authentication stuff was to be done
in hardware by most companies developing iSCSI (I know very little about
authentication and security stuff so I may be completely wrong). From a
software development perspective it would have taken a decent amount of
time and the objective was to get code out so that it could be used for
protocol testing in an iSCSI plugfest.

Hope this clears some of the confusion. If you have any questions,
please let me know. Sorry for the long email.

Thanks
Ashish A. Palekar

