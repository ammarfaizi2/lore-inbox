Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316667AbSHOJuq>; Thu, 15 Aug 2002 05:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316672AbSHOJup>; Thu, 15 Aug 2002 05:50:45 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:1152 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S316667AbSHOJup>; Thu, 15 Aug 2002 05:50:45 -0400
Date: Thu, 15 Aug 2002 12:02:41 +0200
Organization: Pleyades
To: mblack@csihq.com, linux-kernel@vger.kernel.org
Subject: Re: mmap'ing a large file
Message-ID: <3D5B7C41.mail12L21FEQ4@viadomus.com>
References: <050a01c243a9$2afa3590$f6de11cc@black>
In-Reply-To: <050a01c243a9$2afa3590$f6de11cc@black>
User-Agent: nail 9.31 6/18/02
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@pleyades.net>
Reply-To: DervishD <raul@pleyades.net>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Mike :)

>Is there a logical reason why a process can't mmap more than a 2G file?

    Seems to be the value of TASK_MAX if you don't have HIGHMEM.

    Moreover, if you try to mmap a size between TASK_MAX and
ULONG_MAX, you hit a corner case that I fixed in the -ac series, the
2.5.x series and other trees, *except* the 2.4.x 'official', because
Marcelo doesn't apply the patch (three lines... trivial I think).

    Raúl
