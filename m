Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280917AbRKYQbq>; Sun, 25 Nov 2001 11:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280922AbRKYQbf>; Sun, 25 Nov 2001 11:31:35 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:21515 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S280917AbRKYQb3>; Sun, 25 Nov 2001 11:31:29 -0500
Date: Sun, 25 Nov 2001 17:31:25 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Message-ID: <20011125173125.A13119@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011125133020.C1811@emma1.emma.line.org> <20011125150433.CEAE889CAD@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20011125150433.CEAE889CAD@pobox.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "Power off during write operations may make an incomplete sector which
> will report hard data error when read. The sector can be recovered by a
> rewrite operation."

So the proper defect management would be to simply initialize the broken
sector once a fsck hits it (still, I've never seen disks develop so many
bad blocks so quickly as those failed DTLA-307045 drives I had).

Note, the specifications say that the write cache setting is ignored
when the drive runs out of spare blocks for reassignment after defects
(so that the drive can return the error code right away when it cannot
guarantee the write actually goes to disk).

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
