Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbRBNPhK>; Wed, 14 Feb 2001 10:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129069AbRBNPhA>; Wed, 14 Feb 2001 10:37:00 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:10511 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129055AbRBNPgo>;
	Wed, 14 Feb 2001 10:36:44 -0500
To: Donald Becker <becker@scyld.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Ion Badulescu <ionut@moisil.cs.columbia.edu>,
        Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <Pine.LNX.4.10.10102131627180.7141-100000@vaio.greennet>
From: Jes Sorensen <jes@linuxcare.com>
Date: 14 Feb 2001 16:35:51 +0100
In-Reply-To: Donald Becker's message of "Tue, 13 Feb 2001 20:20:35 -0500 (EST)"
Message-ID: <d3snlh5lbc.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Donald" == Donald Becker <becker@scyld.com> writes:

Donald> On 12 Feb 2001, Jes Sorensen wrote:
>> In this case it just results in a performance degradation for 99%
>> of the usage. What about making the change so it is optimized away
>> unless IPX is enabled?

Donald> ???  - It's not just IPX hosts that send 802.3 headers.  -
Donald> While a good initial value might depend on the architecture,
Donald> the best setting is processor implementation and environment
Donald> dependent.  Those details are not known at compile time.  -
Donald> The code path cost of a module option is only a compare and a
Donald> conditional branch.

What else is sending out 802.3 frames these days? I really don't care
about IPX when it comes to performance.

I am just advocating that we optimize for the common case which is DIX
frames and not 802.3.

Jes
