Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291790AbSBAPHD>; Fri, 1 Feb 2002 10:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291788AbSBAPGx>; Fri, 1 Feb 2002 10:06:53 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:48285 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S291786AbSBAPGr>;
	Fri, 1 Feb 2002 10:06:47 -0500
Importance: Normal
MIME-Version: 1.0
Sensitivity: 
To: linux-kernel@vger.kernel.org
Subject: Re: Reported CPU utilization of network server doing constant work - varies
 periodically
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
From: "Mike Spreitzer" <mspreitz@us.ibm.com>
Message-ID: <OFCEFF9C5F.0A126168-ON85256B53.0052821F@pok.ibm.com>
Date: Fri, 1 Feb 2002 10:06:38 -0500
X-MIMETrack: Serialize by Router on D01ML233/01/M/IBM(Release 5.0.9 |November 16, 2001) at
 02/01/2002 10:06:40 AM,
	Serialize complete at 02/01/2002 10:06:40 AM
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mystery solved due to a helpful response from lkml member Mark Hahn, who 
cited the McCanne & Torek paper in the USENIX Winter Conference '93.  My 
clients were synched with their 10 ms clock, which was beating against the 
10 ms clock used on the IA32 server to sample CPU utilization.

McCanne & Torek discuss a better CPU accouting mechanism they put in BSD. 
AIX also apparently does something better (or the RS/6000 clock is much 
worse).  Hint, hint.

Thanks,
Mike
