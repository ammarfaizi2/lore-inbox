Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290218AbSBORBL>; Fri, 15 Feb 2002 12:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290216AbSBORBB>; Fri, 15 Feb 2002 12:01:01 -0500
Received: from [216.151.155.108] ([216.151.155.108]:3856 "EHLO
	varsoon.denali.to") by vger.kernel.org with ESMTP
	id <S290215AbSBORAy>; Fri, 15 Feb 2002 12:00:54 -0500
To: Lorenzo Allegrucci <l.allegrucci@tiscalinet.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Redundant syscalls?
In-Reply-To: <02021517152700.01701@odyssey>
From: Doug McNaught <doug@wireboard.com>
Date: 15 Feb 2002 12:00:51 -0500
In-Reply-To: Lorenzo Allegrucci's message of "Fri, 15 Feb 2002 17:24:02 +0100"
Message-ID: <m3wuxen0ho.fsf@varsoon.denali.to>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lorenzo Allegrucci <l.allegrucci@tiscalinet.it> writes:

> I was wondering why do we need fsetxattr(2), fgetxattr(2) etc when we 
> already have setxattr(2), getxattr(2) etc working on file names
> instead of file descriptors.
> truncate(2)/ftruncate(2) is another more traditional example.

Because you can't reliably derive a file name from an open file
descriptor, so it's useful to have a way to act on the file directly
through the descriptor. 

-Doug
-- 
Let us cross over the river, and rest under the shade of the trees.
   --T. J. Jackson, 1863
