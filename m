Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273524AbRIYUed>; Tue, 25 Sep 2001 16:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273515AbRIYUeX>; Tue, 25 Sep 2001 16:34:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:60433 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S273511AbRIYUeI>; Tue, 25 Sep 2001 16:34:08 -0400
Date: Tue, 25 Sep 2001 22:34:37 +0200
From: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: Ethernet Error Correction
Message-ID: <20010925223437.A21831@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What about implementing an Ethernet error correction in Linux kernel?

Does exist any standard that would normalize ethernet error correction? The
situation is basically this:

Let's say I have two PC's, with ethernet NIC's. An atmospherical optical link
(full duplex) is between them, connected via AUI. The optics goes crazy when
there is a fog of course. But dropping a single bit in 1500 bytes makes a lot
of mess.  There is also unsused src and dest address (12 bytes) which is
obvious and superfluous.  What about kicking the address off and putting some
error correction codes (like Hamming) into it and putting the cards into
promisc mode?  It would make the link work on bigger distance and on thicker
mist.  We could even dynamically change the ECC/data ratio for example with
Reed Solomon Codes. Ethernet modulation is strong gainst sync dropouts so the
bits usually remain their place, just some of them happen to flip. We could
also kick the "lenght" field because end of packet is recognized by a pulse
longer than 200ns, not neither by ECC nor by the length (am I right?).

Is anybody eager to implement this into the kernel? How would it be done
at all? I have personally no idea.

Clock

