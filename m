Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135312AbRAHV5M>; Mon, 8 Jan 2001 16:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132964AbRAHV5G>; Mon, 8 Jan 2001 16:57:06 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:47120 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S133051AbRAHV45>;
	Mon, 8 Jan 2001 16:56:57 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <200101080124.RAA08134@pizda.ninka.net>
From: Jes Sorensen <jes@linuxcare.com>
Date: 08 Jan 2001 22:56:48 +0100
In-Reply-To: "David S. Miller"'s message of "Sun, 7 Jan 2001 17:24:24 -0800"
Message-ID: <d366jp4sin.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

David> I've put a patch up for testing on the kernel.org mirrors:

David> /pub/linux/kernel/people/davem/zerocopy-2.4.0-1.diff.gz

David> It provides a framework for zerocopy transmits and delayed
David> receive fragment coalescing.  TUX-1.01 uses this framework.

David> Zerocopy transmit requires some driver support, things run as
David> they did before for drivers which do not have the support
David> added.  Currently sg+csum driver support has been added to
David> Acenic, 3c59x, sunhme, and loopback drivers.  We had eepro100
David> support coded at one point, but it was removed because we
David> didn't know how to identify the cards which support hw csum
David> assist vs. ones which could not.

I haven't had time to test this patch, but looking over the changes to
the acenic driver I have to say that I am quite displeased with the
way the changes were done. I can't comment on how authors of the other
drivers which were changed feel about it. However I find it highly
annoying that someone goes off and makes major cosmetic structural
changes to someone elses code without even consulting the author who
happens to maintain the code. It doesn't help that the patch reverts
changes that should not have been reverted.

I don't think it's too much to ask that one actually tries to
communicate with an author of a piece of code before making such major
changes and submitting them opting for inclusion in the kernel.

Jes
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
