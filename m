Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289351AbSAOBkp>; Mon, 14 Jan 2002 20:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289350AbSAOBkZ>; Mon, 14 Jan 2002 20:40:25 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:31110
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S289347AbSAOBkX>; Mon, 14 Jan 2002 20:40:23 -0500
Date: Mon, 14 Jan 2002 18:39:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org
Subject: Re: Penelope builds a kernel
Message-ID: <20020115013954.GB3814@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20020114165909.A20808@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020114165909.A20808@thyrsus.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 04:59:09PM -0500, Eric S. Raymond wrote:

[snip]
> She's just heard about a PCMCIA card that has a MEMS array of chemical
> sensors on it.  The thing could replace the bulky, balky
> gel-chromatography setup she's using now, and make it unnecessary for
> her to fight other students for bench time.  There's even a Linux
> driver for the card (and user-space utilities to talk to it) on one of
> the bio sites she uses -- way too specialized an item for her distro
> to carry, and anyway she doesn't want to wait for the next release.
> 
> Penelope needs to build a kernel to support her exotic driver, but she
> hasn't got more than the vaguest idea how to go about it.  The
[snip]

Wrong.  She needs to compile a new module for her kernel.  What might be
useful is some automagic tool that will find the vendor-provided kernel
source tree and config (which is usually /boot/config-`uname -r`, but
still findable anyhow) and then compile said module for her, toss it
into the modules dir and maybe even add it to the always-loaded module
list (just incase hotplug doesn't grok it).

With some support from people writing external drivers, you could even
have a file that lists things like which files are needed, a URL and
version info, and store it someplace too.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
