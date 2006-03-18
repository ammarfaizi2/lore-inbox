Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932856AbWCRCub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932856AbWCRCub (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 21:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932857AbWCRCub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 21:50:31 -0500
Received: from mxsf19.cluster1.charter.net ([209.225.28.219]:57483 "EHLO
	mxsf19.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932856AbWCRCub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 21:50:31 -0500
X-IronPort-AV: i="4.03,106,1141621200"; 
   d="scan'208"; a="101198642:sNHT27865680"
Message-ID: <441B756A.9060309@cybsft.com>
Date: Fri, 17 Mar 2006 20:50:18 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, Esben Nielsen <simlo@phys.au.dk>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Jan Altenberg <tb10alj@tglx.de>,
       Sastien Dugu <sebastien.dugue@bull.net>
Subject: Re: 2.6.16-rc6-rt3
References: <20060314084658.GA28947@elte.hu> <4416C6DD.80209@cybsft.com> <20060314142458.GA21796@elte.hu> <4416F14E.1040708@cybsft.com> <20060317092351.GA18491@elte.hu> <441AE417.1030601@cybsft.com> <20060317203149.GA23069@elte.hu>
In-Reply-To: <20060317203149.GA23069@elte.hu>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
>> OK. Tried rt9 with a clean build and still no joy. I've attached the 
>> log which looks like it could be a similar problem?
> 
> seems to be a different one:
> 
>> input: ImPS/2 Generic Wheel Mouse as /class/input/input1
>> Freeing unused kernel memory: 284k freed
>> Could not allocate 8 bytes percpu data
>> sd_mod: Unknown symbol scsi_print_sense_hdr
> 
> could you increase PERCPU_ENOUGH_ROOM in include/linux/percpu.h? (to 
> e.g. 65536)
> 
> 	Ingo
> 

Perhaps I misunderstood what you wanted me to do before. Just for grins
I doubled the PERCPU_ENOUGH_ROOM to 131072 and have successfully booted
twice now.

-- 
   kr
