Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVGTOvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVGTOvh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 10:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVGTOvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 10:51:36 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:49831 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261282AbVGTOvG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 10:51:06 -0400
X-IronPort-AV: i="3.94,211,1118034000"; 
   d="scan'208"; a="269202443:sNHT24694764"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: page allocation/attributes question (i386/x86_64 specific)
Date: Wed, 20 Jul 2005 09:51:05 -0500
Message-ID: <B1939BC11A23AE47A0DBE89A37CB26B40743C6@ausx3mps305.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: page allocation/attributes question (i386/x86_64 specific)
Thread-Index: AcWMreglo3w1RHozQIiGEqwfWVErfwAiwFjw
From: <Stuart_Hayes@Dell.com>
To: <mingo@elte.hu>
Cc: <ak@suse.de>, <riel@redhat.com>, <andrea@suse.de>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Jul 2005 14:51:05.0752 (UTC) FILETIME=[74D2D180:01C58D3A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> there's one problem with the patch: it breaks things that need the
> low 1MB executable (e.g. APM bios32 calls). It would at a minimum be
> needed to exclude the BIOS area in 0xd0000-0xfffff.  
> 
> 	Ingo

I wrote it to make everything below 1MB executable, if it isn't RAM
according to the e820 map, which should include the BIOS area.  This
includes 0xd0000-0xffff on my system.  Do you think I should explicity
make 0xd0000-0xfffff executable regardless of the e820 map?

Thanks
Stuart
