Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUFVH7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUFVH7T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 03:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUFVH7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 03:59:18 -0400
Received: from hermes.iil.intel.com ([192.198.152.99]:7846 "EHLO
	hermes.iil.intel.com") by vger.kernel.org with ESMTP
	id S261239AbUFVH64 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 03:58:56 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Subject: RE: [PATCH] Handle non-readable binfmt_misc executables
Date: Tue, 22 Jun 2004 10:58:41 +0300
Message-ID: <2C83850C013A2540861D03054B478C060416C513@hasmsx403.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Handle non-readable binfmt_misc executables
thread-index: AcRWtIpI6Y2jLT5rSJur6d06hLH+WwAzx3Zw
From: "Zach, Yoav" <yoav.zach@intel.com>
To: "Arjan van de Ven" <arjanv@redhat.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Jun 2004 07:58:42.0129 (UTC) FILETIME=[BC21D410:01C4582E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Arjan van de Ven [mailto:arjanv@redhat.com] 
>Sent: Sunday, June 20, 2004 13:50
>To: Zach, Yoav
>Cc: Linux Kernel Mailing List
>Subject: Re: [PATCH] Handle non-readable binfmt_misc executables
>

>
>for one, sys_close, while currently exported, shouldn't be really.
>(it is exported right now for a few drivers that have invalid firmware
>loaders that haven't been converted to the firmware loading framework).

What is the reason that sys_close should not be used by modules ?

>In addition it's way overkill, you created the fd so half the safety
>precautions shouldn/t be needed
>

There are some checks that might be skipped. But I think that calling
sys_close is the right thing to do here, because this way future changes
to the procedure of closing an open fd will not need to be copied to
the recovery code of load_misc_binary. Do you expect there will be any
visible gain in performance if the unnecessary steps are skipped ?
Please
remember this is only recovery code - this is not the main stream
execution.

Thanks,
Yoav.

Yoav Zach
IA-32 Execution Layer
Performance Tools Lab
Intel Corp.

