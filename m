Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262938AbVAFSDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262938AbVAFSDb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 13:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbVAFR6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 12:58:09 -0500
Received: from dhost001-17.intermedia.net ([64.78.61.64]:49083 "EHLO
	DHOST001-17.DEX001.intermedia.net") by vger.kernel.org with ESMTP
	id S262954AbVAFRv7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 12:51:59 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: ARP routing issue
Date: Thu, 6 Jan 2005 09:51:55 -0800
Message-ID: <B8561865DB141248943E2376D0E85215846788@DHOST001-17.DEX001.intermedia.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ARP routing issue
Thread-Index: AcT0CnKw21ubt22FScSwDN4WX1Z6sgADdBEA
From: "Steve Iribarne" <steve.iribarne@dilithiumnetworks.com>
To: "Jan De Luyck" <lkml@kcore.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And you see the arp packet coming out which interface??

 

-> -----Original Message-----
-> From: Jan De Luyck [mailto:lkml@kcore.org] 
-> Sent: Thursday, January 06, 2005 8:12 AM
-> To: Steve Iribarne
-> Cc: linux-kernel@vger.kernel.org; linux-net@vger.kernel.org
-> Subject: Re: ARP routing issue
-> 
-> On Thursday 06 January 2005 17:06, Steve Iribarne wrote:
-> > Hi Jan,
-> >
-> >
-> > -> default gateway is set to 10.0.22.1, on eth0.
-> > ->
-> > -> Problem is, if I try to ping from another network
-> > -> (10.216.0.xx) to 10.0.24.xx, i see the following ARP request:
-> > ->
-> > -> arp who-has 10.0.22.1 tell 10.0.24.xx
-> > ->
-> >
-> > You see that coming out the eth0 interface??
-> >
-> > If that is the case it is most definately wrong.  Assuming 
-> that your 
-> > masks are setup properly.  But I haven't worked on the 2.4 
-> kernel for 
-> > a long time so I'm not so sure if what you are seeing is a 
-> bug that 
-> > has been fixed.
-> 
-> The network information is:
-> eth0 10.0.22.xxx mask 255.255.255.0
-> eth1 10.0.24.xxx mask 255.255.255.0
-> 
-> routing:
-> 10.0.22.0 0.0.0.0 255.255.255.0 eth0
-> 10.0.24.0 0.0.0.0 255.255.255.0 eth1
-> 0.0.0.0  10.0.22.1 0.0.0.0  eth0
-> 
-> Jan
-> 
-> --
-> If a man slept by day, he had little time to work.  That was 
-> a satisfying notion to Escargot.
->   -- "The Stone Giant", James P. Blaylock
-> 
