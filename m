Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266236AbUHVGGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266236AbUHVGGQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 02:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266242AbUHVGGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 02:06:16 -0400
Received: from qfep05.superonline.com ([212.252.122.162]:48108 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S266236AbUHVGGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 02:06:14 -0400
From: "Josan Kadett" <corporate@superonline.com>
To: "'Brad Campbell'" <brad@wasp.net.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level
Date: Sun, 22 Aug 2004 09:06:16 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <412836B0.4010309@wasp.net.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcSIDWHNwdALHdU5TWCW0923TNdewQACHx1w
Message-Id: <S266236AbUHVGGO/20040822060614Z+1719@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That is certainly what I require but I need some guidelines; I investigated
into the issue and fount out that;

- By only changing the source address coded in the IP header
- And by just applying checksum to IP header [Not TCP or UDP]

The problem would be gone since when the source IP in the IP address field
is validated, the checksum in the underlying protocol is automatically
validated (because the sender system had already computed this CRC using the
IP address which we want to write onto the packet)

I do not have much time to build a code just for this purpose and thus I am
looking for a simple app. or some other way...


-----Original Message-----
From: Brad Campbell [mailto:brad@wasp.net.au] 
Sent: Sunday, August 22, 2004 8:01 AM
To: Josan Kadett
Cc: 'Chris Siebenmann'; linux-kernel@vger.kernel.org
Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level

Just a completely random thought. What about re-calculating the checksum and
correcting it when the 
packet hits the IP layer prior to it being passed out to the relevant
protocol handlers?

Regards,
Brad


