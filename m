Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267783AbTAXQut>; Fri, 24 Jan 2003 11:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267784AbTAXQut>; Fri, 24 Jan 2003 11:50:49 -0500
Received: from fmr02.intel.com ([192.55.52.25]:51405 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S267783AbTAXQus> convert rfc822-to-8bit; Fri, 24 Jan 2003 11:50:48 -0500
content-class: urn:content-classes:message
Subject: Re: 2.5.59-mm5
Date: Fri, 24 Jan 2003 08:59:37 -0800
Message-ID: <DD755978BA8283409FB0087C39132BD1A07BDE@fmsmsx404.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Topic: Re: 2.5.59-mm5
Thread-Index: AcLDyjf0QtmZYNCVRpyUY5Acv/0Y+A==
From: "Luck, Tony" <tony.luck@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Jan 2003 16:59:38.0317 (UTC) FILETIME=[FAC9D7D0:01C2C3C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

  So what anticipatory scheduling does is very simple: if an application
  has performed a read, do *nothing at all* for a few milliseconds.  Just
  return to userspace (or to the filesystem) in the expectation that the
  application or filesystem will quickly submit another read which is
  closeby.

Do you need to give a process being woken from the read an extra priority
boost to make sure that it actually gets run in your "few milliseconds"
window.  It would be a shame to leave the disk idle for the interval, and
then discover that the process scheduler had been running other stuff, so
that the reader didn't get a chance to issue the next read.

-Tony Luck  

