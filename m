Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbTAaRuN>; Fri, 31 Jan 2003 12:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261872AbTAaRuN>; Fri, 31 Jan 2003 12:50:13 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:65224 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261868AbTAaRuM>;
	Fri, 31 Jan 2003 12:50:12 -0500
Date: Fri, 31 Jan 2003 18:59:27 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@codemonkey.org.uk>, Tomas Szepe <szepe@pinerecords.com>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Rodland <arodland@noln.com>,
       john@grabjohn.com
Subject: Re: [PATCH] 2.5.59 morse code panics
Message-ID: <20030131185927.B25927@ucw.cz>
References: <20030130150709.GC701@louise.pinerecords.com> <20030130173642.GB25824@codemonkey.org.uk> <1043952334.31674.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1043952334.31674.20.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Jan 30, 2003 at 06:45:34PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2003 at 06:45:34PM +0000, Alan Cox wrote:

> On Thu, 2003-01-30 at 17:36, Dave Jones wrote:
> > As this patch further builds upon the previous one,
> > It'd take a complete change of mind on his part to take
> > this as it is.
> 
> If its attached to atkbd then its not a PCism and its now
> nicely modularised in the atkbd driver. Providing we have
> a clear split between the core "morse sender" and the
> platform specific morse output device (do we want 
> morse_ops 8)) it should be clean and you can write morse
> drivers for pc speaker, for non pc keyboard and even for
> soundblaster 8)

It should be in the keyboard.c file, using input_event() to blink the
LEDs. This way it'll work on all archs in 2.5.

I will not accept it as a patch for atkbd.c, unless there is a strong
reason to do it there.

-- 
Vojtech Pavlik
SuSE Labs
