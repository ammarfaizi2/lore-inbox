Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315928AbSEGSJD>; Tue, 7 May 2002 14:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315931AbSEGSJB>; Tue, 7 May 2002 14:09:01 -0400
Received: from holomorphy.com ([66.224.33.161]:37610 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315928AbSEGSI5>;
	Tue, 7 May 2002 14:08:57 -0400
Date: Tue, 7 May 2002 11:07:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Love <rml@tech9.net>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4-ac: migration_init improvements
Message-ID: <20020507180725.GV32767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Love <rml@tech9.net>, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
In-Reply-To: <1020794038.806.25.camel@bigsur>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2002 at 10:53:57AM -0700, Robert Love wrote:
> The attached patch simplifies the migration_init code (an ugly lot) with
> a simpler mechanism.  This is Erich Focht's version which is now in
> 2.5.  It has proved stable both there and in my testing.
> The new method is to bring up the first migration_thread, and then use
> it to migrate the remaining threads to their respective CPUs.  The
> method makes sense and removes a lot of code.
> This patch also includes a boot hang fix demonstrated on arches where
> logical CPU mapping != physical CPU mapping.  The bug was reported and
> fixed by James Bottomley in 2.5.
> Patch is against 2.4.19-pre7-ac4, please apply.
> 	Robert Love

No objections here. Focht's code works just as well or better, and has
further advantages with respect to hotplug cpu support.


Cheers,
Bill
