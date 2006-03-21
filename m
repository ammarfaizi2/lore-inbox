Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422641AbWCUSVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422641AbWCUSVF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 13:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422640AbWCUSVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 13:21:04 -0500
Received: from smtp.uaf.edu ([137.229.34.30]:54026 "EHLO smtp.uaf.edu")
	by vger.kernel.org with ESMTP id S1422641AbWCUSVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 13:21:01 -0500
From: Joshua Kugler <joshua.kugler@uaf.edu>
Organization: UAF Center for Distance Education - IT
To: linux-kernel@vger.kernel.org
Subject: Re: Lifetime of flash memory
Date: Tue, 21 Mar 2006 09:20:53 -0900
User-Agent: KMail/1.7.2
Cc: John Richard Moser <nigelenki@comcast.net>
References: <44203179.3090606@comcast.net>
In-Reply-To: <44203179.3090606@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603210920.53549.joshua.kugler@uaf.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 March 2006 08:01, John Richard Moser wrote:
> I have a kind of dumb question.  I keep hearing that "USB Flash Memory"
> or "Compact Flash Cards" and family have "a limited number of writes"
> and will eventually wear out.  Recommendations like "DO NOT PUT A SWAP
> FILE ON USB MEMORY" have come out of this.  In fact, quoting
> Documentation/laptop-mode.txt:
>
>   * If you're worried about your data, you might want to consider using
>     a USB memory stick or something like that as a "working area". (Be
>     aware though that flash memory can only handle a limited number of
>     writes, and overuse may wear out your memory stick pretty quickly.
>     Do _not_ use journalling filesystems on flash memory sticks.)
>
> The question I have is, is this really significant?  I have heard quoted
> that flash memory typically handles something like 3x10^18 writes; and
> that compact flash cards, USB drives, SD cards, and family typically
> have integrated control chipsets that include wear-leveling algorithms
> (built-in flash like in an iPaq does not; hence jffs2).  Should we
> really care that in about 95 billion years the thing will wear out
> (assuming we write its entire capacity once a second)?
>
> I call FUD.

Search for a thread on LKML having to do with enabling "sync" on removable 
media, especially VFAT media.  If you are copying a large file, and the FAT 
on the device is being updated with every block, you can literally fry your 
device in a matter of minutes, because the FAT is always in the same spot, 
thus it is always overwriting the same spot.

j----- k-----

-- 
Joshua Kugler                 PGP Key: http://pgp.mit.edu/
CDE System Administrator             ID 0xDB26D7CE
http://distance.uaf.edu/
