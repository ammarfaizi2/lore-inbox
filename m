Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279568AbRJ2VoJ>; Mon, 29 Oct 2001 16:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279569AbRJ2Vnx>; Mon, 29 Oct 2001 16:43:53 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:56324 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S279568AbRJ2Vnp>; Mon, 29 Oct 2001 16:43:45 -0500
Message-ID: <001201c160c2$a91ac3b0$f5976dcf@nwfs>
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
To: "Ashish A. Palekar" <apalekar@trebia.com>, <greearb@candelatech.com>,
        <nitin.dhingra@dcmtech.co.in>, <linux-kernel@vger.kernel.org>
In-Reply-To: <3BDDADFF.77EB8912@trebia.com>
Subject: Re: iSCSI support for Linux
Date: Mon, 29 Oct 2001 14:42:38 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Emulex in their Fibre Channel Drivers, support a fiber Channel LAN driver
that uses
an iSCSI implementation on Linux.  You can get the code from their website.
It does
not appear to be a complete implementation, but it does work.  What is
missing is the
device side of the logic, which seems to be a lot of work, but perhaps
someone else
knows where the other side is.  I  have heard that the BSD CAM layer is
something
people are looking at providing in Linux.

Jeff

----- Original Message -----
From: "Ashish A. Palekar" <apalekar@trebia.com>
To: <greearb@candelatech.com>; <nitin.dhingra@dcmtech.co.in>;
<linux-kernel@vger.kernel.org>
Sent: Monday, October 29, 2001 12:29 PM
Subject: Re: iSCSI support for Linux


> Ben/Nitin:
>
> I was going through some of the emails you guys had sent out on the LKML
> about iscsi support. I think there is some confusion about the projects.
>
> There are three different projects that I am aware of and are currently
> active.
>
> 1. Cisco
> 2. Intel
> 3. UNH - Chris Loveland and myself were both from UNH and have since
> graduated. However, there is still active development work.
>
> As far as the UNH project goes:
>
> We have been working on both the Initiator (host) and the Target
> (Server) side. The Initiator side should work directly with the SCSI
> Initiator mid-level. As I am given to understand, the code was revved up
> to version 6.
>
> On the Target side, the project is a little more elaborate. Since there
> is no existing SCSI Target support, we have developed a SCSI Target
> Mid-level. This has three front-ends written for it which support:
>
> 1. Adaptec's SCSI Encapsulation Protocol (defunct last November - since
> iSCSI has become the dominant SAN over TCP/IP protocol)
> 2. QLogic ISP 2200 A Fibre Channel driver
> 3. iSCSI driver (and this works on the TCP/IP software stack which Linux
> has) - so it is pretty much limited by whatever ethernet cards Linux
> supports (including GigE). We did not have access to TCP accelerated
> cards so the development on those has not been done.
>
> Thus you have three target drivers written for the SCSI Target mid-level
> which we has been written. For the iSCSI driver itself - there are four
> target drivers one for rev 0, rev 03, rev 06 and rev 08.
>
> The UNH drivers are available for download from:
>
> http://www.iol.unh.edu/consortiums/fc/fc_linux.html
> http://www.iol.unh.edu/consortiums/iscsi
>
> They have been GPLed. Lots of people are currently trying out the code
> and letting me and the other developers know about the bugs. Ideally, we
> would like to fix those (however, the rev version of the draft keeps on
> changing :-(). The Initiator code is fairly straightforward. For how to
> use the target code, my thesis is available with the tar ball from one
> of these sites.
>
> Okay .. to your question about authentication Ben .. the consideration
> we had to make was that a lot of the authentication stuff was to be done
> in hardware by most companies developing iSCSI (I know very little about
> authentication and security stuff so I may be completely wrong). From a
> software development perspective it would have taken a decent amount of
> time and the objective was to get code out so that it could be used for
> protocol testing in an iSCSI plugfest.
>
> Hope this clears some of the confusion. If you have any questions,
> please let me know. Sorry for the long email.
>
> Thanks
> Ashish A. Palekar
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

