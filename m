Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265570AbSLPGiX>; Mon, 16 Dec 2002 01:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265608AbSLPGiX>; Mon, 16 Dec 2002 01:38:23 -0500
Received: from angband.namesys.com ([212.16.7.85]:9606 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S265570AbSLPGiV>; Mon, 16 Dec 2002 01:38:21 -0500
Date: Mon, 16 Dec 2002 09:46:16 +0300
From: Oleg Drokin <green@namesys.com>
To: Tupshin Harper <tupshin@tupshin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: JDIRTY JWAIT errors in 2.4.19
Message-ID: <20021216094616.A20997@namesys.com>
References: <3DFAF9EF.6000501@tupshin.com> <20021214135550.A13549@namesys.com> <3DFD74B5.5050206@tupshin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <3DFD74B5.5050206@tupshin.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, Dec 15, 2002 at 10:37:41PM -0800, Tupshin Harper wrote:
> >Can you please execute SysRq-T, decode it with ksymoops and send us the 
> >result?
> I have succeeded in reproducing this problem at will (and 
> deterministically) with a SysRq enabled kernel.

Ok.

> I can reproduce the problem consistently by doing a cp -av of a 
> directory(haven't tried other cp permutations, guessing it wouldn't make 
> a difference) containing three mp3 files from one location on a 
> partition to another location on the same reiserfs partition. During the 
> third file, cp hangs(continues to use 80%+ of the CPU), and is 
> unkillable. A few minutes later, it starts generating the same JDIRTY 
> error messages that I reported before.

Can you please produce a metadump data for us?
use debugreiserfs -p /dev/yourdevice | gzip -9c >metadata.gz
then tell us where we can get that file.
Also please use recent reiserfsprogs for that operation
(e.g. version 3.6.4 available from us: ftp://ftp.namesys.com/pub/reiserprogs )

> I have not tried to do any kind of reiserfs check or repair on the 
> filesystem, and I can trigger this problem at any point if you would 
> like me to test further.

Let's see if we can reproduce it locally after you give us the metadata.

Thank you.

Bye,
    Oleg
