Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266519AbUIVR54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbUIVR54 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 13:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266569AbUIVR54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 13:57:56 -0400
Received: from ariel.xerox.com ([13.13.138.17]:38868 "EHLO
	ariel.useastgw.xerox.com") by vger.kernel.org with ESMTP
	id S266519AbUIVR5y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 13:57:54 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6529.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: pci "other" bridge devices in 2.4
Date: Wed, 22 Sep 2004 13:54:39 -0400
Message-ID: <556445368AFA1C438794ABDA8901891C7C8F14@usa0300ms03.na.xerox.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: pci "other" bridge devices in 2.4
Thread-Index: AcSgzTs0BQ91jYXxT0G+cPXfXtv45Q==
From: "Leisner, Martin" <Martin.Leisner@xerox.com>
To: <linux-kernel@vger.kernel.org>
Cc: <Leisner@rochester.rr.com>, "Lund, Nathan" <Nathan.Lund@xerox.com>
X-OriginalArrivalTime: 22 Sep 2004 17:54:40.0116 (UTC) FILETIME=[3B8EA340:01C4A0CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems when non PCI-PCI bridge devices are seen, linux
(I'm using 2.4.27, 2.6.x looks the same) just punts.

It seems reasonable to say:
	if(header_type ==PCI_HEADER_TYPE_BRIDGE)	{
		if(class == PCI_CLASS_BRIDGE_PCI)
			do what we do now
		else {
	  		some type of funky device, process first two
bars
			and IRQ, leave bridge stuff for device driver
		}

It seems I going to have to put in a number of tweaks in a few 
places...but this behavior seems "better"

marty
