Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293453AbSCSBib>; Mon, 18 Mar 2002 20:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293458AbSCSBiM>; Mon, 18 Mar 2002 20:38:12 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:23054 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S293453AbSCSBh5>; Mon, 18 Mar 2002 20:37:57 -0500
Date: Tue, 19 Mar 2002 02:37:55 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, Dieter.Nuetzel@hamburg.de,
        linux-kernel@vger.kernel.org
Subject: Re: 7.52 second kernel compile
Message-ID: <20020319023755.A28383@devcon.net>
Mail-Followup-To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
	"David S. Miller" <davem@redhat.com>, torvalds@transmeta.com,
	Dieter.Nuetzel@hamburg.de, linux-kernel@vger.kernel.org
In-Reply-To: <200203182312.24958.Dieter.Nuetzel@hamburg.de> <Pine.LNX.4.33.0203181434440.10517-100000@penguin.transmeta.com> <20020318.162031.98995076.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2002 at 04:20:31PM -0800, David S. Miller wrote:
>    
>    Or maybe the program is just flawed, and the interesting 1/8 pattern comes 
>    from something else altogether.
> I think the weird Athlon behavior has to do with the fact that
> you've made your little test program as much of a cache tester
> as a TLB tester :-)

Erm, you forgot COW semantics. The accesses to buffer are actually all
going to the same physical address. As CPU caches work on physical
addresses AFAIK (everything else would be just stupid ;-), there are
no cache misses (disregarding a few produced by IRQs/scheduling etc.).

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
