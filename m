Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265092AbSKNTuH>; Thu, 14 Nov 2002 14:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265168AbSKNTuH>; Thu, 14 Nov 2002 14:50:07 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:23244 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265092AbSKNTuF>; Thu, 14 Nov 2002 14:50:05 -0500
Subject: Non-blocking lock requests during the grace period
To: nfs@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.2a (Intl) 23 November 1999
Message-ID: <OFCACC2A48.A38B3611-ON87256C71.006D0CEB@us.ibm.com>
From: Juan Gomez <juang@us.ibm.com>
Date: Thu, 14 Nov 2002 11:56:42 -0800
X-MIMETrack: Serialize by Router on D03NM694/03/M/IBM(Release 6.0 [IBM]|October 31, 2002) at
 11/14/2002 12:57:45
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org






I found out that the current Linux client of lockd blocks non-blocking lock
requests while the server is in the grace period.
I think this is incorrect behavior and I am wondering if the will exists
out there to correct this and return "resource not available"
to the process when a request is for a *non-blocking* lock while the server
is in the grace period.

It is extremelly odd to issue a *non-blocking* call and be blocked in the
kernel for about a minute when the server happens
to be in the grace period.

This consists of a minor change to nlmclnt_call() and I would send the
patch if someone will review and include it.

Regards, Juan


