Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265259AbTLRQnW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 11:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265260AbTLRQnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 11:43:22 -0500
Received: from holomorphy.com ([199.26.172.102]:25236 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265259AbTLRQnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 11:43:20 -0500
Date: Thu, 18 Dec 2003 08:42:28 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Miroslaw KLABA <totoro@totoro.be>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Double Interrupt with HT
Message-ID: <20031218164228.GD31393@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Miroslaw KLABA <totoro@totoro.be>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	john stultz <johnstul@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <20031215155843.210107b6.totoro@totoro.be> <1071603069.991.194.camel@cog.beaverton.ibm.com> <1071615336.3fdf8d6840208@ssl0.ovh.net> <1071618630.1013.11.camel@cog.beaverton.ibm.com> <1071630228.3fdfc794eb353@ssl0.ovh.net> <1071717730.1117.26.camel@cog.beaverton.ibm.com> <20031218131437.239e69e5.totoro@totoro.be> <Pine.LNX.4.58.0312180849480.1710@montezuma.fsmlabs.com> <20031218173528.370211b6.totoro@totoro.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031218173528.370211b6.totoro@totoro.be>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 18, 2003 at 05:35:28PM +0100, Miroslaw KLABA wrote:
> My fault...
> It works now.
> `while true; do date; sleep 1; done` counts well now.
> Thanks.
> But now, how may I help to find this bug in apic code?
> Miro
> # cat /proc/interrupts 
>            CPU0       CPU1       
>   0:      12421          0          XT-PIC  timer
>   1:          2          0          XT-PIC  keyboard
>   2:          0          0          XT-PIC  cascade
>   4:         16          0          XT-PIC  serial
>   8:          1          0          XT-PIC  rtc
>  11:        642          0          XT-PIC  eth0
>  14:       2865          0          XT-PIC  ide0
> NMI:          0          0 
> LOC:      12355      12353 
> ERR:          0
> MIS:          0

Known issue. Boot with norqbalance to work around it.

-- wli
