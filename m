Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269799AbRHINZn>; Thu, 9 Aug 2001 09:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269798AbRHINZd>; Thu, 9 Aug 2001 09:25:33 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:2309 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S269660AbRHINZQ>; Thu, 9 Aug 2001 09:25:16 -0400
Date: Thu, 9 Aug 2001 15:25:24 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic change patch)
Message-ID: <20010809152524.E14108@emma1.>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
In-Reply-To: <01080315090600.01827@starship> <Pine.GSO.4.21.0108031400590.3272-100000@weyl.math.psu.edu> <9keqr6$egl$1@penguin.transmeta.com>, <9keqr6$egl$1@penguin.transmeta.com> <20010804100143.A17774@weta.f00f.org> <3B6B4B21.B68F4F87@zip.com.au>, <3B6B4B21.B68F4F87@zip.com.au> <20010804131904.E18108@weta.f00f.org> <3B6C642F.D0358401@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3B6C642F.D0358401@zip.com.au>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Aug 2001, Andrew Morton wrote:

> Sorry, Chris - I was being even more than usually stupid.  All
> you need do is overload the return value from file_operations.fsync().
> It currently returns zero on success or negative error.  You can
> just define a return value of "1" to mean that the fs has taken
> care of syncing the directory info and no further action is needed
> at the fs layer.

But ensure that the user space never sees the "1" return value from
fsync() itself.

-- 
Matthias Andree
