Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269659AbTGNJrX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 05:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269941AbTGNJrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 05:47:22 -0400
Received: from holomorphy.com ([66.224.33.161]:51149 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S269659AbTGNJrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 05:47:22 -0400
Date: Mon, 14 Jul 2003 03:03:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Morris <jmorris@intercode.com.au>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: kmap_types.h (was: Re: Linux 2.4.22-pre3)
Message-ID: <20030714100319.GG15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	James Morris <jmorris@intercode.com.au>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0307052151180.21992@freak.distro.conectiva> <Pine.GSO.4.21.0307141153340.20906-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0307141153340.20906-100000@vervain.sonytel.be>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jul 2003, Marcelo Tosatti wrote:
>>   o [CRYPTO-2.4]: Add dummy kmap_types.h header for sparc64

On Mon, Jul 14, 2003 at 11:55:40AM +0200, Geert Uytterhoeven wrote:
> What are the actual purpose and semantics of the KM_* types? I need to add them
> for m68k to make crypto compile.
> Gr{oetje,eeting}s,
> 						Geert

They're per-cpu virtualspace reservations for predetermined purposes.
It's for a variant of kmap() usable under spinlocks and in interrupt
handlers. If you don't have highmem, you just don't care.


-- wli
