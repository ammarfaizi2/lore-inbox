Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316175AbSETSAi>; Mon, 20 May 2002 14:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316177AbSETSAh>; Mon, 20 May 2002 14:00:37 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10769 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316175AbSETSAg>; Mon, 20 May 2002 14:00:36 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: 2.5.14+ ALSA OSS emulation
Date: Mon, 20 May 2002 17:59:29 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <acbdi1$ljb$1@penguin.transmeta.com>
In-Reply-To: <m179bTr-0005khC@gherkin.frus.com>
X-Trace: palladium.transmeta.com 1021917625 24996 127.0.0.1 (20 May 2002 18:00:25 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 20 May 2002 18:00:25 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <m179bTr-0005khC@gherkin.frus.com>,
Bob_Tracy <rct@gherkin.frus.com> wrote:
>In the 2.5.14 patchset, the following change was made in
>linux/sound/core/Config.in:
>
>-bool '  OSS API emulation' CONFIG_SND_OSSEMUL $CONFIG_SND
>+dep_bool '  OSS API emulation' CONFIG_SND_OSSEMUL $CONFIG_SND
>
>This breaks the OSS API emulation for people building their ALSA sound
>drivers as modules (CONFIG_SND == "m").  The following patch applied
>against the 2.5.16 kernel accomplishes what I think the author intended:

Good catch.

However, the simpler fix is to use "dep_mbool", which exists exactly for
this reason. 

		Linus
