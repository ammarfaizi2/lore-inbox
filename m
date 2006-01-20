Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWATKyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWATKyR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 05:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWATKyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 05:54:17 -0500
Received: from gate.in-addr.de ([212.8.193.158]:50116 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S1750812AbWATKyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 05:54:16 -0500
Date: Fri, 20 Jan 2006 11:53:06 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Phillip Susi <psusi@cfl.rr.com>, Neil Brown <neilb@suse.de>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Lincoln Dale (ltd)" <ltd@cisco.com>, Michael Tokarev <mjt@tls.msk.ru>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
Message-ID: <20060120105306.GY22163@marowsky-bree.de>
References: <26A66BC731DAB741837AF6B2E29C1017D47EA0@xmb-hkg-413.apac.cisco.com> <Pine.LNX.4.61.0601181427090.19392@yvahk01.tjqt.qr> <17358.52476.290687.858954@cse.unsw.edu.au> <43D00FFA.1040401@cfl.rr.com> <17360.5011.975665.371008@cse.unsw.edu.au> <43D02033.4070008@cfl.rr.com> <17360.9233.215291.380922@cse.unsw.edu.au> <43D04828.8010107@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43D04828.8010107@cfl.rr.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-01-19T21:17:12, Phillip Susi <psusi@cfl.rr.com> wrote:

> I am under the impression that dm is simpler/cleaner than md.  That 
> impression very well may be wrong, but if it is simpler, then that's a 
> good thing. 

That impression is wrong in that general form. Both have advantages and
disadvantages.

I've been an advocate of seeing both of them merged, mostly because I
think it would be beneficial if they'd share the same interface to
user-space to make the tools easier to write and maintain.

However, rewriting the RAID personalities for DM is a thing only a fool
would do without really good cause. Sure, everybody can write a
RAID5/RAID6 parity algorithm. But getting the failure/edge cases stable
is not trivial and requires years of maturing.

Which is why I think gentle evolution of both source bases towards some
common API (for example) is much preferable to reinventing one within
the other.

Oversimplifying to "dm is better than md" is just stupid.



Sincerely,
    Lars Marowsky-Brée

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

