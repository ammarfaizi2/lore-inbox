Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131669AbRCUSTw>; Wed, 21 Mar 2001 13:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131722AbRCUSTm>; Wed, 21 Mar 2001 13:19:42 -0500
Received: from nrg.org ([216.101.165.106]:16954 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S131669AbRCUST3>;
	Wed, 21 Mar 2001 13:19:29 -0500
Date: Wed, 21 Mar 2001 10:18:38 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: "David S. Miller" <davem@redhat.com>
cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel
In-Reply-To: <15032.30533.638717.696704@pizda.ninka.net>
Message-ID: <Pine.LNX.4.05.10103211012100.500-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2001, David S. Miller wrote:
> Basically, anything which uses smp_processor_id() would need to
> be holding some lock so as to not get pre-empted.

Not necessarily.  Another solution for the smp_processor_id() case is
to ensure that the task can only be scheduled on the current CPU for the
duration that the value of smp_processor_id() is used.  Or, if the
critical region is very short, to disable interrupts on the local CPU.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

MontaVista Software                             nigel@mvista.com

