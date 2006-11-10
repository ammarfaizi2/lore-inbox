Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946814AbWKJXh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946814AbWKJXh0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 18:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946822AbWKJXhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 18:37:25 -0500
Received: from gw.goop.org ([64.81.55.164]:39852 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1946814AbWKJXhZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 18:37:25 -0500
Message-ID: <45550D2F.2070004@goop.org>
Date: Fri, 10 Nov 2006 15:37:19 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Magnus Damm <magnus.damm@gmail.com>
CC: Horms <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Magnus Damm <magnus@valinux.co.jp>, linux-kernel@vger.kernel.org,
       Vivek Goyal <vgoyal@in.ibm.com>, Andi Kleen <ak@muc.de>,
       fastboot@lists.osdl.org, Dave Anderson <anderson@redhat.com>
Subject: Re: [PATCH 02/02] Elf: Align elf notes properly
References: <20061102101942.452.73192.sendpatchset@localhost>	 <20061102101949.452.23441.sendpatchset@localhost>	 <m1psbwzpmx.fsf@ebiederm.dsl.xmission.com>	 <20061110005051.GB4107@verge.net.au> <aec7e5c30611092000k397fb578xc59a990043fc310a@mail.gmail.com>
In-Reply-To: <aec7e5c30611092000k397fb578xc59a990043fc310a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm wrote:
> I see no point in aligning to 32-bit boundaries on 64-bit platforms.
> Their intention was most likely to align to the word size IMO, so this
> is most likely a "thinko" left over from whoever ported the code from
> 32-bit to 64-bit.

I don't think so.  Since Elf64 notes still have 32-bit values in them,
32-bit alignment seems the most sensible.  It would certainly be an
irritation to have Elf32 and Elf64 Notes with basically the same
definition, but with different alignments.

    J
