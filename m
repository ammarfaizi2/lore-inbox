Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318186AbSGYAJH>; Wed, 24 Jul 2002 20:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318200AbSGYAJG>; Wed, 24 Jul 2002 20:09:06 -0400
Received: from virtmail.zianet.com ([216.234.192.37]:39398 "HELO zianet.com")
	by vger.kernel.org with SMTP id <S318186AbSGYAJF>;
	Wed, 24 Jul 2002 20:09:05 -0400
Message-ID: <3D3F446A.1070105@zianet.com>
Date: Wed, 24 Jul 2002 18:20:58 -0600
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020723
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Andries.Brouwer@cwi.nl, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.28 and partitions
References: <Pine.GSO.4.21.0207241925450.14656-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:

>On Thu, 25 Jul 2002 Andries.Brouwer@cwi.nl wrote:
>
>
>Separate set of patches.  As it is, struct hd_struct is still there and
>still not modified.  And it has unsigned long.  It will become sector_t.
>
>Actually, I'm not all that sure that we want u64 here.  The thing being,
>start_sect shouldn't be bigger than sector_t (see how it's used).  And
>64bit arithmetics on 32bit boxen sucks big way.  I'm not too concerned
>about adding start_sect per se - it's done once per request and it's
>noise compared to the rest of work.  However, long long for sector_t
>will hit in a lot of more interesting code paths.
>
>That stuff becomes an issue for 2Tb disks.  Do we actually have something
>that large attached to 32bit boxen?
>
I do.  Two 3ware 7850's with 8 160GB hd's on each.  Wanted
to software strip but I hit the 2TB limit and ended up settling
with software mirror.  This is on a dual Athlon box.

>
>... and still use i386 with these disks?  ia64 is stillborn, but x86-64
>promises to be more useful than Itanic.
>
Will be nice when it arrives.

Steve



