Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278927AbRKIAqa>; Thu, 8 Nov 2001 19:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278943AbRKIAqV>; Thu, 8 Nov 2001 19:46:21 -0500
Received: from pizda.ninka.net ([216.101.162.242]:14232 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S278940AbRKIAqD>;
	Thu, 8 Nov 2001 19:46:03 -0500
Date: Thu, 08 Nov 2001 16:45:39 -0800 (PST)
Message-Id: <20011108.164539.42460282.davem@redhat.com>
To: rml@tech9.net
Cc: cyjamten@ihug.com.au, linux-kernel@vger.kernel.org
Subject: Re: AMD761Agpgart+Radeon64DDR+kernel+2.4.14...no go...
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1005239692.939.34.camel@phantasy>
In-Reply-To: <20011108123808.I27652@suse.de>
	<3BEA7525.7070807@ihug.com.au>
	<1005239692.939.34.camel@phantasy>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There are actually very huge issues with the AMD761 chipset and the
current AGPGART drivers.  There are several hardware workarounds
necessary for that driver when using many AGP graphics cards, and I'm
trying to get info out of AMD to deal with this.

My radeon, which works perfectly fine with all current drivers on an
ALI based chipset, will lockup when running quake3 or even running one
of the xscreensaver OpenGL hacks.

I honestly got myself an ALI based board for my Athlon XP cpus when I
discovered these problems so that I can play quake3 while trying to
get the info out of AMD :-)

So that people don't think I'm talking out of my butt, have a look
at this:

http://www2.amd.com:80/us-en/assets/content_type/white_papers_and_tech_docs/24081.pdf

On page 210 there is a section titled "AGP Miniport Driver
Requirements", and to paraphrase this section basically tells
the reader "Yes, there are problems with some AGP cards and the
AMD761 chipset, to get that fixed just use our Windows drivers."

Anyone who reads the current agpgart amd761 support, can tell pretty
clearly that we don't have any of these mysterious workarounds
implemented.

Franks a lot,
David S. Miller
davem@redhat.com
