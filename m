Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264868AbTLFCsy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 21:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264935AbTLFCsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 21:48:54 -0500
Received: from holomorphy.com ([199.26.172.102]:43989 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264868AbTLFCsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 21:48:53 -0500
Date: Fri, 5 Dec 2003 18:48:28 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Colin Coe <colin@coesta.com>, linux-kernel@vger.kernel.org
Subject: Re: SMP broken on Dell PowerEdge 4100/200 under 2.6.0-testxx?
Message-ID: <20031206024828.GH8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Colin Coe <colin@coesta.com>, linux-kernel@vger.kernel.org
References: <3350.192.168.1.3.1070677965.squirrel@www.coesta.com> <20031206024251.GG8039@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031206024251.GG8039@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 06, 2003 at 10:32:45AM +0800, Colin Coe wrote:
>>            CPU0       CPU1
>>   0:     633122         30    IO-APIC-edge  timer
>>   1:        207              IO-APIC-edge  i8042
>>   2:                              XT-PIC  cascade
>>   4:         48          1    IO-APIC-edge  serial
>>   5:        449          1   IO-APIC-level  eth1
>>  10:        135          1   IO-APIC-level  aic7xxx
>>  11:       1447          1   IO-APIC-level  eth0
>>  12:         61              IO-APIC-edge  i8042
>>  14:                       IO-APIC-level  CS46XX
>>  15:      14982          1   IO-APIC-level  megaraid

On Fri, Dec 05, 2003 at 06:42:51PM -0800, William Lee Irwin III wrote:
> 2.6 does balancing across packages, not logical cpus, so this will
> happen and it will be largely harmless, except for what appears to
> be some kind of bug where it's stealing the timer from logical cpu 1.

Replied-to text trimming bogon, apparently. They're "LOC:" for local
APIC timer interrupts. What's reported for irq 0 above is odd though.


-- wli
