Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129839AbRCGOxp>; Wed, 7 Mar 2001 09:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129854AbRCGOxg>; Wed, 7 Mar 2001 09:53:36 -0500
Received: from t2.redhat.com ([199.183.24.243]:59640 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S129839AbRCGOxN>; Wed, 7 Mar 2001 09:53:13 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3AA3E63E.80101@AnteFacto.com> 
In-Reply-To: <3AA3E63E.80101@AnteFacto.com>  <Pine.LNX.4.30.0102191626090.29121-100000@sparrow.websense.net> 
To: Padraig Brady <Padraig@AnteFacto.com>
Cc: William Stearns <wstearns@pobox.com>,
        ML-linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OFFTOPIC] Hardlink utility - reclaim drive space 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Mar 2001 14:52:19 +0000
Message-ID: <12975.983976739@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Padraig@AnteFacto.com said:
> Wouldn't it be cool to have an extended attribute for files called
> "Copy on Write", so then you could hardlink all duplicate files
> together, but when a file is modified a copy is transparently created.

> The only problem I see with this is that you wouldn't have enough
> space to store a copy of a file, what would you do in this case, just
> return an error on write? 

Yep. write(2) is allowed to return -ENOSPC, even when you're not extending
the file you're writing to. Think about holes and log-structured
filesystems.

--
dwmw2


