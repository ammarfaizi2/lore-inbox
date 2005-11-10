Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbVKJXbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbVKJXbk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 18:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbVKJXbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 18:31:40 -0500
Received: from scl-ims.phoenix.com ([216.148.212.222]:58229 "EHLO
	scl-exch2k.phoenix.com") by vger.kernel.org with ESMTP
	id S1751230AbVKJXbj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 18:31:39 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Reading BIOS information from a kernel driver
Date: Thu, 10 Nov 2005 15:31:38 -0800
Message-ID: <0EF82802ABAA22479BC1CE8E2F60E8C37BA443@scl-exch2k3.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Reading BIOS information from a kernel driver
Thread-Index: AcXlbSAEKh1rVl22TdedRvA8Rx7DiQA4YwXw
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Steven Schveighoffer" <StevenS@NetworkEngines.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Nov 2005 23:31:39.0426 (UTC) FILETIME=[E6390020:01C5E64E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>Steven Schveighoffer
>Sent: Wednesday, November 09, 2005 12:36 PM
>To: linux-kernel@vger.kernel.org
>Subject: Reading BIOS information from a kernel driver
>
>I am trying to read a string that the BIOS has placed into memory.
>
>The BIOS placed the string into memory at real-mode address F000:FA00
>(i.e. physical address FFA00h).
>
>1. Is there a linear address which always contains this address
>location?  i.e. if there is a spot where I can do:
>
>char * mystring = (char *)0xMagicAddress;
>
>2. If not, how do I map a linear address to this physical address so I
>can read it?
>
>I'm pretty sure that the string can be read, but I would prefer to know
>exactly where the string is located before looking.  For example, the
>following command finds the string:
>
>dd if=/proc/kcore bs=1024 count=3000 | grep mystring
>
>-Steve

I think you are looking for phys_to_virt(0xffa00)

Aleks.
