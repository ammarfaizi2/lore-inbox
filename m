Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131271AbRCVWxJ>; Thu, 22 Mar 2001 17:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132226AbRCVWw7>; Thu, 22 Mar 2001 17:52:59 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22026 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131271AbRCVWwv>; Thu, 22 Mar 2001 17:52:51 -0500
Subject: Re: [PATCH] Prevent OOM from killing init
To: dledford@redhat.com (Doug Ledford)
Date: Thu, 22 Mar 2001 22:53:39 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        stephenc@theiqgroup.com (Stephen Clouse),
        dwguest@win.tue.nl (Guest section DW),
        riel@conectiva.com.br (Rik van Riel),
        orourke@missioncriticallinux.com (Patrick O'Rourke),
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <3ABA7851.AB080D44@redhat.com> from "Doug Ledford" at Mar 22, 2001 05:10:25 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gDxd-0003Tw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > How do you return an out of memory error to a C program that is out of memory
> > due to a stack growth fault. There is actually not a language construct for it
> 
> Simple, you reclaim a few of those uptodate buffers.  My testing here has

If you have reclaimable buffers you are not out of memory. If oom is triggered
in that state it is a bug. If you are complaining that the oom killer triggers
at the wrong time then thats a completely unrelated issue.

