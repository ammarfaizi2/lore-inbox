Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286951AbSABLjp>; Wed, 2 Jan 2002 06:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286950AbSABLjg>; Wed, 2 Jan 2002 06:39:36 -0500
Received: from dsl-213-023-043-195.arcor-ip.net ([213.23.43.195]:35599 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S286951AbSABLjY>;
	Wed, 2 Jan 2002 06:39:24 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Daniel Phillips <phillips@bonn-fries.net>
To: Ville Herva <vherva@niksula.hut.fi>, linux-kernel@vger.kernel.org
Subject: Re: Ext2 groups descriptor corruption in 2.2 - Phillips's patch seems to work
Date: Wed, 2 Jan 2002 12:42:54 +0100
X-Mailer: KMail [version 1.3.2]
Cc: sak@iki.fi, phillips@innominate.de, viro@math.psu.edu,
        alan@lxorguk.ukuu.org.uk, tao@acc.umu.se
In-Reply-To: <20020101152802.A1331@niksula.cs.hut.fi>
In-Reply-To: <20020101152802.A1331@niksula.cs.hut.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E16LjnL-00010c-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 1, 2002 02:28 pm, Ville Herva wrote:
> A while ago Daniel Phillips posted a patch for 2.4.0-test11 to cure groups
> descriptor corruption in ext2.
> 
> The corruption had been seen with 2.2 and 2.0 for a long time. It happens
> most likely in situations where there are many hard links to same inode (see
> first report below).
> 
> I gather this fix has gone into 2.4 mainline in different form (see Al
> Viro's fix below). It never went to 2.2 (nor 2.0) afaik.
> 
> The fix applies pretty cleanly to 2.2.20, and has been tested by me and
> Samuli Kärkkäinen (again, see first problem report) for about a month now.
> Samuli reports that he had been able to reproduce the bug in about 10-15
> backup runs with unpatched 2.2.18. With the patch applied, it hasn't
> appeared in well over 20 runs. My experience is similar with 2.2.20.
> 
> I haven't tested the patch on 2.0, but the problem seems to exists in 2.0 as
> well. Taking a quick look, it seems the patch can be applied to 2.0.40pre3
> with minor tweaking (s/ext2_get_group_desc/get_group_desc/g, remove
> le16_to_cpu() from patch, and perhaps the add the additional get_group_desc
> return value error checking to 2.0 ialloc.c that 2.2 has.)
> 
> Alan, David, perhaps this would be worth applying to next 2.2/2.0 pre? Al,
> Daniel, what do you think? Should the patch be tidied up before 2.2
> inclusion (as was done for 2.4)?

Since you have done such a thorough job of documenting the whole thing, why 
not drop the other shoe and submit the patches?

--
Daniel
