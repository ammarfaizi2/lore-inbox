Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274813AbRIUUM3>; Fri, 21 Sep 2001 16:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274812AbRIUUMT>; Fri, 21 Sep 2001 16:12:19 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:4282 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S274810AbRIUUMF>;
	Fri, 21 Sep 2001 16:12:05 -0400
Date: Fri, 21 Sep 2001 22:12:25 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Significant performace improvements on reiserfs systems, kupdated bugfixes
Message-ID: <20010921221225.A22402@schmorp.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010920101544.A14526@turbolinux.com> <Pine.LNX.4.30.0109210015190.19847-100000@gamma.student.ljbc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0109210015190.19847-100000@gamma.student.ljbc>
X-Operating-System: Linux version 2.4.8-ac9 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2001 at 12:22:59AM +0800, Beau Kuiper <kuib-kl@ljbc.wa.edu.au> wrote:
> Also, it is nicer behaviour not to write out to disk before the time
> indicated in the bdflush tuning structure. It allows sys admins to better
> tune the overal performace of a system. (unless the kernel need s more
> free memory)

A contiguous write doesn't cost anything much, so it could be major
win if the kernel could flush dirty buffers that are behind and after
the dirty block to be written. But this would nicely conflict with
allocate-on-flush ;)

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
