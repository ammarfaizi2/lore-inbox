Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161018AbVKDEav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161018AbVKDEav (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 23:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030601AbVKDEav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 23:30:51 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:28636 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030600AbVKDEau
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 23:30:50 -0500
In-Reply-To: <7e77d27c0511030526g45d8f6e6l@mail.gmail.com>
To: Yan Zheng <yzcorp@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [PATCH][MCAST]Two fix for implementation of MLDv2 .
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF70243A3E.F658C3A4-ON882570AF.001699E7-882570AF.0018C8DB@us.ibm.com>
From: David Stevens <dlstevens@us.ibm.com>
Date: Thu, 3 Nov 2005 20:30:57 -0800
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 6.53HF654 | July 22, 2005) at
 11/03/2005 21:31:00,
	Serialize complete at 11/03/2005 21:31:00
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yan,
        I'm looking at this one. My original interpretation was that a
group and source specific query should only be answered if the source
were explicitly listed (which is what the code does), but I see your 
point.
A general or group-specific query should still be answered with the
existing code, and the unsolicited reports will also include the EXCLUDE
records for that group, so I'm not aware of any actual circumstances
where a multicast router wouldn't forward. But maybe you have such
a case. An administrator-initiated query, however, would certainly be
misleading to the administrator in the example you provided, and so
far I tend to agree that there should be a record in the report.
        However, I'm not sure your solution is appropriate since it
appears to include EXCLUDE records in cases where they aren't
needed.
        So, I'll look at this more carefully and see if I still agree
it needs a fix and whether or not your patch, or some alternative
method might be more appropriate. But it'll probably be sometime
next week before I'll be done reviewing/considering alternatives on
this one.

                                        +-DLS

