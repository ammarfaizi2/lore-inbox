Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbULGSGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbULGSGN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 13:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbULGSGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 13:06:12 -0500
Received: from viking.sophos.com ([194.203.134.132]:27662 "EHLO
	viking.sophos.com") by vger.kernel.org with ESMTP id S261676AbULGSGL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 13:06:11 -0500
MIME-Version: 1.0
X-MIMETrack: S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 07/12/2004 18:06:02,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 07/12/2004 18:06:02,
	Serialize complete at 07/12/2004 18:06:02,
	S/MIME Sign failed at 07/12/2004 18:06:02: The cryptographic key was not
 found,
	S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 07/12/2004 18:06:06,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 07/12/2004 18:06:06,
	Serialize complete at 07/12/2004 18:06:06,
	S/MIME Sign failed at 07/12/2004 18:06:06: The cryptographic key was not
 found,
	Serialize by Router on Mercury/Servers/Sophos(Release 6.5.2|June 01, 2004) at
 07/12/2004 18:06:10,
	Serialize complete at 07/12/2004 18:06:10
To: linux-kernel@vger.kernel.org
Cc: viro@parcelfarce.linux.theplanet.co.uk
Subject: 2.6 path_lookup bug?
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OFA528AB05.6BC2F495-ON80256F63.006300EA-80256F63.00636FCB@sophos.com>
From: tvrtko.ursulin@sophos.com
Date: Tue, 7 Dec 2004 18:06:06 +0000
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

What would you expect to happen if one called: 

path_lookup("foo:/bar", &nd); ?

I suspect there is something fishy going on there because when I do that 
"/bar" gets destabilised and soon afterwards, another lookup on it will 
BUG at dcache.c:276.
 
Comments?


