Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263702AbUE1RKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbUE1RKe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 13:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUE1RKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 13:10:34 -0400
Received: from fmr05.intel.com ([134.134.136.6]:26523 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263702AbUE1RKZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 13:10:25 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: CONFIG_IRQBALANCE for AMD64?
Date: Fri, 28 May 2004 10:09:31 -0700
Message-ID: <7F740D512C7C1046AB53446D372001730182BAE2@scsmsx402.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CONFIG_IRQBALANCE for AMD64?
thread-index: AcRESJ40M0xIqZbNQomQ3L1r/VAyDQAhyfrQ
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Chris Wedgwood" <cw@f00f.org>, "Arjan van de Ven" <arjanv@redhat.com>,
       "Anton Blanchard" <anton@samba.org>
Cc: "Thomas Zehetbauer" <thomasz@hostmaster.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 May 2004 17:09:33.0153 (UTC) FILETIME=[8BC01D10:01C444D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>owner@vger.kernel.org] On Behalf Of Chris Wedgwood
>Sent: Thursday, May 27, 2004 2:38 PM
>To: Arjan van de Ven; Anton Blanchard
>Cc: Thomas Zehetbauer; 'linux-kernel@vger.kernel.org'
>Subject: Re: CONFIG_IRQBALANCE for AMD64?
>
>On Thu, May 27, 2004 at 06:50:25PM +0200, Arjan van de Ven wrote:
>
>> irqbalanced has NOT been obsoleted by CONFIG_IRQBALANCE.
>
>On Fri, May 28, 2004 at 03:03:34AM +1000, Anton Blanchard wrote:
>
>> > Seems to work, just like the i386 irqbalanced before it has been
>> > obsoleted by CONFIG_IRQBALANCE
>>
>> No, CONFIG_IRQBALANCE is an x86 specific hack.
>
The issue is a xAPIC thing, and the both kernel-level and user-level are
applicable to x86_64 as well. 

The kernel does the default IRQ balancing, without assuming a user-level
irq balancing (because it's a distribution issue). If the user-level has
better knowledge, it just does a write to /proc/irq/N/smp_affinity to
bind that IRQ to a particular CPU, as Arjan's program is doing. In other
words, the kernel-level does _not_ move the ones bound by the
user-level.

>
>
>Why do we have CONFIG_IRQBALANCE at all then?
>
Today Linux is used for various configurations, including the ones that
substantially limit the set of user commands, libraries, etc. So we want
to keep it.

Jun

>
>
>  --cw
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

