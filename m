Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264925AbTBCLyU>; Mon, 3 Feb 2003 06:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264969AbTBCLyU>; Mon, 3 Feb 2003 06:54:20 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:52843
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S264925AbTBCLyU>; Mon, 3 Feb 2003 06:54:20 -0500
Date: Mon, 3 Feb 2003 07:02:47 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Pavel Machek <pavel@suse.cz>
cc: Mikael Pettersson <mikpe@csd.uu.se>, <ak@suse.de>,
       <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: Re: Switch APIC to driver model (and make S3 sleep with APIC on)
In-Reply-To: <20030202124235.GA133@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0302030657310.9361-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Feb 2003, Pavel Machek wrote:

> +	set_fixmap_nocache(FIX_APIC_BASE, apic_phys);		/* FIXME: this is needed for S3 resume, but why? */

Intel recommends a strong uncacheable mapping otherwise it may exhibit 
undeterministic behaviour. Perhaps that could be it?

	Zwane

