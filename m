Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbTFIQuM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 12:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264448AbTFIQuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 12:50:12 -0400
Received: from fmr05.intel.com ([134.134.136.6]:16343 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264444AbTFIQuE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 12:50:04 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: /proc/bus/pci
Date: Mon, 9 Jun 2003 10:03:40 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A84725A2DC@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: /proc/bus/pci
Thread-Index: AcMsi4BOC91YB6ifTfWbQ0ElFTXM/wCHKUjQ
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Robert White" <rwhite@casabyte.com>,
       "Linus Torvalds" <torvalds@transmeta.com>,
       "Albert Cahalan" <albert@users.sourceforge.net>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, <davem@redhat.com>,
       <bcollins@debian.org>, <wli@holomorphy.com>, <tom_gall@vnet.ibm.com>,
       <anton@samba.org>
X-OriginalArrivalTime: 09 Jun 2003 17:03:40.0747 (UTC) FILETIME=[1377B9B0:01C32EA9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What about "PCI segment"?

Another overloaded CS word but it's certainly better than some of the
alternatives below. It's also the only one that is actually used in a
relevant specification (the ACPI spec.)

Regards - Andy

> -----Original Message-----
> From: Robert White [mailto:rwhite@casabyte.com] 
> Sent: Friday, June 06, 2003 5:25 PM
> To: Linus Torvalds; Albert Cahalan
> Cc: linux-kernel; davem@redhat.com; bcollins@debian.org; 
> wli@holomorphy.com; tom_gall@vnet.ibm.com; anton@samba.org
> Subject: RE: /proc/bus/pci
> 
> 
> My Humble Opinion:
> 
> "hose0" -> bad, I know I didn't have a clue where it came from
> 
> "domain0" -> obscure but mathematical 8-), probably hard to 
> teach what with
> the name used all over heck
> 
> "phb0" -> "eh what is phb?"  "primary host bridge"...
> 
> "bridge0" -> not bad, is it platform agnostic? (e.g. is the connection
> called a bridge on non- Intel/AMD/PS platforms?)  don't 
> know...  but if it
> is... good
> 
> Note:  There are no "good" synonyms for "Domain"  (from M-W.com:)
> 
> "field, bailiwick, champaign, demesne, dominion, province, 
> sphere, terrain,
> territory, walk"
> 
> So, my heard groans for another "domain" in the computer, and 
> I like the way
> bridge reads
> 
> "devices/bridge0/bus2/dev11/fn0/whatever"
> 
> but regardless (going back to pc-isms) that puts things like 
> the pci-agp
> "bridge" and such into the namespace if one were to be especially
> conformant, which may or may not be a good thing.
> 
> Rob.
> 
> 
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Linus Torvalds
> Sent: Thursday, June 05, 2003 8:52 AM
> To: Albert Cahalan
> Cc: linux-kernel; davem@redhat.com; bcollins@debian.org;
> wli@holomorphy.com; tom_gall@vnet.ibm.com; anton@samba.org
> Subject: Re: /proc/bus/pci
> 
> 
> 
> On Thu, 5 Jun 2003, Albert Cahalan wrote:
> >
> > Some of the IBMers use "phb" instead of "hose" or "domain".
> 
> Gods, did they run out of vowels in _that_ part of IBM too?
> 
> Where do they go? Is there somebody at IBM that hoards 
> vowels, and will
> one day hold the rest of the world hostage? "Mwahahahaa! If 
> you don't buy
> support from IBM, you can never use the letter 'A' again! 
> Whahahahhhaah!".
> 
> I can see it now.
> 
> 
> What the _f*ck_ is wrong with just calling it "PCI domain". 
> It's a fine
> word, and yes, "domain" is used commonly in computer 
> language, but that's
> a _good_ thing. Everybody immediately understands what it is about.
> 
> There is no goodness to acronyms where you have to be some 
> "insider" to
> know what the hell it means. That "hose" thing has the same problem: I
> don't know about anybody else, but to me a "hose" is a logn 
> narrow conduit
> for water, and a "PCI hose" doesn't much make sense to me.
> 
> A "phb" just makes me go "Whaa?"
> 
> 		Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
