Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264475AbRFXUJ5>; Sun, 24 Jun 2001 16:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264477AbRFXUJi>; Sun, 24 Jun 2001 16:09:38 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:60921 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S264475AbRFXUJc>; Sun, 24 Jun 2001 16:09:32 -0400
Mime-Version: 1.0
Message-Id: <a05101000b75bf87731b8@[192.168.239.105]>
In-Reply-To: <Pine.LNX.4.33.0106242133550.19801-100000@druid.if.uj.edu.pl>
In-Reply-To: <Pine.LNX.4.33.0106242133550.19801-100000@druid.if.uj.edu.pl>
Date: Sun, 24 Jun 2001 21:07:55 +0100
To: Maciej Zenczykowski <maze@druid.if.uj.edu.pl>,
        <linux-kernel@vger.kernel.org>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Thrashing WITHOUT swap.
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Now my question is how can it be
>thrashing with swap explicitly turned off?

Easy.  All applications are themselves swap space - the binary is 
merely memory-mapped onto the executable file.  When the system gets 
low on memory, the only thing it can do is purge some binary pages, 
and then repeatedly page them back in from the original executable 
file.

If you added a little bit of swap, it would be able to page out some 
idle data rather than binaries, and would probably avoid thrashing.
-- 
--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
website:  http://www.chromatix.uklinux.net/vnc/
geekcode: GCS$/E dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$
           V? PS PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
tagline:  The key to knowledge is not to rely on people to teach you it.
