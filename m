Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310202AbSCLGuu>; Tue, 12 Mar 2002 01:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310438AbSCLGuk>; Tue, 12 Mar 2002 01:50:40 -0500
Received: from pizda.ninka.net ([216.101.162.242]:27847 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S310202AbSCLGuc>;
	Tue, 12 Mar 2002 01:50:32 -0500
Date: Mon, 11 Mar 2002 22:47:08 -0800 (PST)
Message-Id: <20020311.224708.08403487.davem@redhat.com>
To: tngo@broadcom.com
Cc: linux-kernel@vger.kernel.org, gignatin@broadcom.com, gyoung@broadcom.com
Subject: Re: [BETA] First test release of Tigon3 driver
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <030801c1c960$ed24f470$f665030a@lt-ir002050.broadcom.com>
In-Reply-To: <030801c1c960$ed24f470$f665030a@lt-ir002050.broadcom.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Timothy Ngo" <tngo@broadcom.com>
   Date: Mon, 11 Mar 2002 16:57:44 -0800

   The driver was also written in a way that proprietary information
   about the hardware would not be unnecessarily disclosed. This is
   necessary to protect our intellectual property and to keep a
   competitive edge in the highly competitive Gigabit NIC marketplace.
   
Then please tell us why other gigabit vendors are able to work with
the Linux developer community and Broadcom is not able to? :-)

   At this point, we cannot support the Linux open source community
   to write their own driver.

Frankly, we don't need your support anymore.  Once it was realized
that we would not receive any help from you we did everything in our
power to produce a driver and situation that did not require
Broadcom's help.  We couldn't depend upon you, so we took appropriate
actions.

   In one benchmark test, we've achieved better than 1.8 Gigabit total
   throughput using jumbo frames.

Our driver is faster than yours, and this is backed up by reports done
by public testers of our driver.  Our cases are well documented,
whereas all you can do is mention is a magic "one benchmark test" and
a magic performance result which contains no details.  It seems that
knowing more about the hardware than anyone else doesn't seem to help
you all that much in this area.  This I find amusing. :-)

We make regular and detailed releases.  Our work is publicly
documented and very accessible to the community.  Whereas Broadcom
does releases behind closed doors and only distribution vendors even
hear about when this happens.

   [BRCM] Our driver is 117K, Intel's driver is 82K, the Altima driver is 82K.
   It has
   a lot of features and carries all backward compatible for all chips
   including
   firmware.

Our driver fully supports not only the same exact hardware and
revisions as your driver, it supports MORE chipsets (and MORE
features) than your driver including but not limited to the Syskonnect
Tigon3 based boards.

Your argument for having a huge driver binary size is garbage.
Our driver supports all of your hardware fully, and is HALF the
size.

Your arguments are not only erroneous, they show how deeply you do
not understand the problems the Linux developer community has with
your driver.
   
   > > Finally, their driver is just plain buggy, they have
   > > code which tries to use page_address() on pages which are potentially
   > > in highmem and that is guarenteed to oops.
   
   [BRCM] It is true that the driver uses page_address() in one subroutine that
   is used to workaround a problem on the very early 5700 chip. But this routine
   is not used at all, it was there intially to support early rev of the
   silicon. It was removed in later version of the Broadcom driver.
   
Removing it removes support for HIGHMEM zerocopy in your driver for
those revisions when, in fact, you could have simply used calls to
skb_copy() to fix the bug.  Our driver handles this correctly, not
penalizing performance on this card revision regardless of how "rare"
or "unimportant" it is.  What you have done to fix this bug in your
driver is precisely the kind of garbage change we would never accept
into a driver found in the Linux sources.

Frankly I am disgusted with Broadcom's attitude here.  No other vendor
gives us this much of a problem with their gigabit Linux drivers.

Intel is not crying about "competitive gigabit market" to us, they
have cleaned up their driver and allow Jeff Garzik to co-maintain it
with them.  Same story for NatSemi's gigabit parts for which Ben
Lahaise (another one of those "arrogant" Linux developers :-) is the
sole driver author.

So please, take your sob story and excuses elsewhere.  The world is
crumbling from underneath you, and luckily the Linux community has a
solution to your attitude and ignorance in this situation.  We have
our own driver and thus we can and will choose to ignore you.  And
ignore you we will if you continue to act this way.

One of the things that Broadcom really, and truly, wants to protect is
their broken NICE extensions in their drivers.  They want to retain
this so they can ship their proprietary VLAN trunking and load
balancing kernel module.  Not only are the NICE extentions truly
disgusting, making use of them from binary-only Linux kernel modules
is of questionable legality.

Jeff and I have made numerous efforts to fix this relationship, both
publicly, directly with Broadcom, and more recently directly with
vendors who use Broadcom's parts.  It is a real shame (and IMHO a PR
disaster for Broadcom, considering how other gigabit vendors interact
with us) that they can't figure out that they are fighting a losing
battle and that it is in their interest to work together and not
against us on these matters.
