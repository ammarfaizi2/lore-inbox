Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281157AbRKGX6d>; Wed, 7 Nov 2001 18:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281161AbRKGX6X>; Wed, 7 Nov 2001 18:58:23 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:43396 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S281157AbRKGX6M>; Wed, 7 Nov 2001 18:58:12 -0500
Date: Thu, 8 Nov 2001 00:58:04 +0100 (CET)
From: bartscgr@t-online.de (Guenter Bartsch)
X-X-Sender: guenter@goofy.disney.gb
Reply-To: bartscgr@studbox.uni-stuttgart.de
To: linux-kernel@vger.kernel.org
Subject: DVD_LU_SEND_AGID slow since 2.4.10
Message-ID: <Pine.LNX.4.40.0111080054480.26201-100000@goofy.disney.gb>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo list,

ever since 2.4.10 the SEND_AGID DVD_AUTH control seems to be very slow
(used in libdvdcss, freezes xine for up to 30sec). The code that's
executed seems to be:

    dvd_authinfo auth_info;

    memset( &auth_info, 0, sizeof( auth_info ) );
    auth_info.type = DVD_LU_SEND_AGID;
    auth_info.lsa.agid = *pi_agid;

    i_ret = ioctl( i_fd, DVD_AUTH, &auth_info );

anybody here have any idea what might cause this? could this really be
just a caching problem caused by the new vm or is this something
completely different I observe here? The -ac kernel series doesn't seem to
have this problem on the same machine.

Any comments apreciated, please cc as I'm not subscribed to the list

Kind regards,

   guenter

--
time is a funny concept


