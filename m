Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313440AbSDLIIm>; Fri, 12 Apr 2002 04:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313442AbSDLIIl>; Fri, 12 Apr 2002 04:08:41 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:35031 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S313440AbSDLIIl>;
	Fri, 12 Apr 2002 04:08:41 -0400
Date: Fri, 12 Apr 2002 10:08:38 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux as a minicomputer ?
Message-ID: <20020412100838.A17963@ucw.cz>
In-Reply-To: <20020411154601.GY17962@antefacto.com> <20020411164331.GR612@gallifrey> <20020411184923.A15238@ucw.cz> <1018544869.962.22.camel@psuedomode> <20020411191249.A15435@ucw.cz> <3CB69032.D332FA51@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2002 at 09:43:46AM +0200, Helge Hafting wrote:

> > 2) If you hack out the VT switching out of X, then still each X server
> > will disable all PCI resources for other video cards, because it
> > believes it owns the system. This will freeze all other active X
> > servers.
> 
> Do X somehow _depend_ on disabling other cards or is this
> another thing that could be #ifdefed out?
> Assuming, of course that the resources don't
> overlap in any unhealthy way.

They do. Almost always, there is the legacy VGA i/o space, which is
needed to initialize the secondary card(s) by BIOS ran in vm86 space.

After #ifdefing the disabling out, the Xservers crashed reproducibly.

-- 
Vojtech Pavlik
SuSE Labs
