Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbVDRMWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbVDRMWU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 08:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbVDRMWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 08:22:20 -0400
Received: from hell.sks3.muni.cz ([147.251.210.30]:28331 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S262051AbVDRMWK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 08:22:10 -0400
Date: Mon, 18 Apr 2005 14:22:02 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: E1000 - page allocation failure - saga continues :(
Message-ID: <20050418122202.GE26030@mail.muni.cz>
References: <20050414214828.GB9591@mail.muni.cz> <4263A3B7.6010702@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4263A3B7.6010702@univ-nantes.fr>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 02:10:31PM +0200, Yann Dupont wrote:
> I have those problems too. The (temporary ?) fix is to raise the
> min_free_kb to an higher value.
> echo 65535 > /proc/sys/vm/min_free_kbytes
> 
> Maybe such an high value is totally silly, but at least I don't have
> those messages.

I know that kernel 2.6.6-bk4 works. So were there some memory manager changes
since 2.6.6? If so it looks like there are some bugs. 
On the other hand, ethernet driver should not allocate much memory but rather
drop packets.

Btw, are you using some TCP tweaks? E.g. I have default TCP window size 1MB.

-- 
Luká¹ Hejtmánek
