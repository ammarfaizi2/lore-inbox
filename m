Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265270AbTL0AAL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 19:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265273AbTL0AAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 19:00:10 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:59832 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S265270AbTLZX75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 18:59:57 -0500
Date: Fri, 26 Dec 2003 15:59:47 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: azarah@nosferatu.za.org
cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 sound output - wierd effects
Message-ID: <2060000.1072483186@[10.10.2.4]>
In-Reply-To: <1072482611.21020.71.camel@nosferatu.lan>
References: <1080000.1072475704@[10.10.2.4]> <1072479167.21020.59.camel@nosferatu.lan>  <1480000.1072479655@[10.10.2.4]> <1072480660.21020.64.camel@nosferatu.lan>  <1640000.1072481061@[10.10.2.4]> <1072482611.21020.71.camel@nosferatu.lan>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, 2003-12-27 at 01:24, Martin J. Bligh wrote:
>> > Over here the your main one if not using oss emu is alsa-lib  I used
>> > 0.9.8 for most of the time, but latest 1.0_rc[12] works as well.
>> 
>> Debian doesn't seem to have an alsa-lib exactly.
> 
> Should provide /usr/lib/libasound.so.2.0.0 (version may differ).

Aha, thanks ;-)

$ dpkg -S /usr/lib/libasound.so.2.0.0
libasound2: /usr/lib/libasound.so.2.0.0

Package: libasound2
Versions: 
0.9.0beta10a-3(/var/lib/apt/lists/ftp.debian.org_debian_dists_stable_main_binary-i386_Packages)(/var/lib/dpkg/status)

Which is probably horribly old, knowing Debian stable ;-)

>> >  Also, does xmms use oss or alsa as output
>> > driver - switching between the two may or may not improve things?
>> 
>> Errm. No idea which it uses, nor can I see anything in it that switches ;-)
>
> If you right click on xmms, and then select options->preferences, on the
> first page to the bottom there should be output plugin.  If you cannot
> select alsa, see if there is a xmms-alsa or libxmms-alsa plugin.  Sorry,
> I do not know Debian that well.

Thanks, it was on OSS - there's no ALSA selection, nor can I find one.
There's probably one in unstable somewhere, but ... see below.
 
> Basically as sombody else noted - it might be with the OSS emulation,
> so we want to use native alsa support with xmms ...

I'll play with it - should narrow things down. However, fundamentally,
it used to work in 2.5.74, and is broken as of test3 ... that strongly
implies to me there's a kernel problem. I'd rather fix OSS emulation
if possible, and save everybody migrating to 2.6 from this pain ... ;-)

M.

