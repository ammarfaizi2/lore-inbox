Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264649AbUFTKmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264649AbUFTKmJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 06:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265770AbUFTKmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 06:42:09 -0400
Received: from hermes.iil.intel.com ([192.198.152.99]:43666 "EHLO
	hermes.iil.intel.com") by vger.kernel.org with ESMTP
	id S264649AbUFTKmG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 06:42:06 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Subject: RE: [PATCH] Handle non-readable binfmt_misc executables
Date: Sun, 20 Jun 2004 13:41:30 +0300
Message-ID: <2C83850C013A2540861D03054B478C060416BC17@hasmsx403.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Handle non-readable binfmt_misc executables
thread-index: AcRWCzIt6e+vscTkQR+YOMot35DDrgAp0I4Q
From: "Zach, Yoav" <yoav.zach@intel.com>
To: <arjanv@redhat.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: <torvalds@osdl.org>
X-OriginalArrivalTime: 20 Jun 2004 10:41:31.0964 (UTC) FILETIME=[2694D7C0:01C456B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure I understand the problem. Load_elf_binary also
uses sys_close for recovery in case of error. Can you please
give me more details on the problems you see with using sys_close ?

Thanks,
Yoav.

Yoav Zach
IA-32 Execution Layer
Performance Tools Lab
Intel Corp.


>-----Original Message-----
>From: Arjan van de Ven [mailto:arjanv@redhat.com] 
>Sent: Saturday, June 19, 2004 17:39
>To: Linux Kernel Mailing List
>Cc: Zach, Yoav; torvalds@osdl.org
>Subject: Re: [PATCH] Handle non-readable binfmt_misc executables
>
>
>> +_error_close_file:
>> +	if (fd_binary > 0) {
>> +		sys_close (fd_binary);
>> +		fd_binary = -1;
>> +		bprm->file = NULL;
>> +	
>
>
>ewww sys_close.... there HAS to be a better way to do that... 
>
