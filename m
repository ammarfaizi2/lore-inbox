Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265900AbUH1Kdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbUH1Kdg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 06:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUH1Kdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 06:33:36 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:28548 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S267415AbUH1KaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 06:30:09 -0400
Date: Sat, 28 Aug 2004 12:30:05 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Gabucino <gabucino@mplayerhq.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pwc+pwcx is not illegal
Message-ID: <20040828103005.GA1841@ucw.cz>
References: <20040828081534.GA30353@mail.banki.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828081534.GA30353@mail.banki.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 10:15:34AM +0200, Gabucino wrote:
> Guess GPL maniacs would have been happy, should avifile/MPlayer/xine never
> supported loading Win32 video+audio codecs. These players are probably
> considered non-GPL by Linus. Fine. Way to go, kernel developers.
> 
> Maybe you people should instead test release kernels at least with NFS before
> releasing. It's kinda basic feature, ya know.
> 
> Anyway, GPL only forbids _distribution_ of GPL+binary stuff, not the
> _possibility_ to use it. Time for Linus and Greg to come to their
> senses.

Loading binary modules is considered OK in the kernel in case the binary
module was implemented independently of the kernel.

So if the same logic was applied to mplayer and win32 codecs, then that
would be considered OK.

What is not considered OK is to develop a module with the sole intent to
use it with the kernel and then distribute it as binary only. While we
kernel developers can't do much about it, at least we don't support it
by allowing specific hooks for that.

In the case of pwc+pwcx, pwcx (the decoder module) is completely useless
without pwc (the driver module), and thus is obviously falling in the
second class described above.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
