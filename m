Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWGFSrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWGFSrp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 14:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWGFSrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 14:47:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:39751 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750738AbWGFSro convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 14:47:44 -0400
X-IronPort-AV: i="4.06,214,1149490800"; 
   d="scan'208"; a="94213068:sNHT14927549"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] IA64 kprobe invalidate icache of jump buffer
Date: Thu, 6 Jul 2006 11:47:29 -0700
Message-ID: <8A3E977AB3C24845947ADAAE0526E39511A7B9@orsmsx419.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] IA64 kprobe invalidate icache of jump buffer
Thread-Index: AcaeSg41dxefQ9HuS/eE8LcrwY4qrAC4nuLg
From: "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>
To: "Mao, Bibo" <bibo.mao@intel.com>, "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>,
       "Masami Hiramatsu" <hiramatu@sdl.hitachi.co.jp>,
       "Prasanna S Panchamukhi" <prasanna@in.ibm.com>,
       "Ananth N Mavinakayanahalli" <ananth@in.ibm.com>,
       "Jim Keniston" <jkenisto@us.ibm.com>,
       "SystemTAP" <systemtap@sources.redhat.com>
X-OriginalArrivalTime: 06 Jul 2006 18:47:30.0030 (UTC) FILETIME=[A24E20E0:01C6A12C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Mao, Bibo 
>Sent: Sunday, July 02, 2006 7:37 PM
>To: Andrew Morton
>Cc: linux-kernel@vger.kernel.org; Keshavamurthy, Anil S; 
>Masami Hiramatsu; Prasanna S Panchamukhi; Ananth N 
>Mavinakayanahalli; Jim Keniston; SystemTAP; Mao, Bibo
>Subject: [PATCH] IA64 kprobe invalidate icache of jump buffer
>
>Hi,
>
>   Kprobe inserts breakpoint instruction in probepoint and then jumps
>to instruction slot when breakpoint is hit, the instruction slot icache
>must be consistent with dcache. Here is the patch which invalidates
>instruction slot icache area.
>   Without this patch, in some machines there will be fault 
>when executing
>instruction slot where icache content is inconsistent with 
>dcache.This patch
>is based on 2.6.17 version.	
>
>Signed-off-by: bibo,mao <bibo.mao@intel.com>
Acked-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
