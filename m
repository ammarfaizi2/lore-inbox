Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275277AbRI0F0o>; Thu, 27 Sep 2001 01:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275767AbRI0F0d>; Thu, 27 Sep 2001 01:26:33 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:23304 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S275277AbRI0F0P>;
	Thu, 27 Sep 2001 01:26:15 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200109270526.f8R5Qd209258@saturn.cs.uml.edu>
Subject: Re: Ethernet Error Correction
To: clock@atrey.karlin.mff.cuni.cz (Karel Kulhavy)
Date: Thu, 27 Sep 2001 01:26:39 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010925223437.A21831@atrey.karlin.mff.cuni.cz> from "Karel Kulhavy" at Sep 25, 2001 10:34:37 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karel Kulhavy writes:

> Let's say I have two PC's, with ethernet NIC's. An atmospherical optical link
> (full duplex) is between them, connected via AUI. The optics goes crazy when
> there is a fog of course. But dropping a single bit in 1500 bytes makes a lot
> of mess.  There is also unsused src and dest address (12 bytes) which is
> obvious and superfluous.  What about kicking the address off and putting some
> error correction codes (like Hamming) into it and putting the cards into
> promisc mode?  It would make the link work on bigger distance and on thicker
> mist.  We could even dynamically change the ECC/data ratio for example with
> Reed Solomon Codes. Ethernet modulation is strong gainst sync dropouts so the
> bits usually remain their place, just some of them happen to flip. We could
> also kick the "lenght" field because end of packet is recognized by a pulse
> longer than 200ns, not neither by ECC nor by the length (am I right?).

Do something like RAID 5 over multiple packets. Then you can
handle cards that just drop corrupt packets.
