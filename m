Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264210AbTE0WHf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 18:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264212AbTE0WHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 18:07:35 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:54243 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264210AbTE0WHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 18:07:33 -0400
Date: Tue, 27 May 2003 15:18:30 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: marcelo@conectiva.com.br, m.c.p@wolk-project.de,
       linux-kernel@vger.kernel.org, c-d.hailfinger.kernel.2003@gmx.net,
       manish@storadinc.com, christian.klose@freenet.de, wli@holomorphy.com
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-Id: <20030527151830.40b3d281.akpm@digeo.com>
In-Reply-To: <20030527202520.GN3767@dualathlon.random>
References: <3ED2DE86.2070406@storadinc.com>
	<200305271952.34843.m.c.p@wolk-project.de>
	<Pine.LNX.4.55L.0305271457090.756@freak.distro.conectiva>
	<200305272004.02376.m.c.p@wolk-project.de>
	<20030527182547.GG3767@dualathlon.random>
	<Pine.LNX.4.55L.0305271530580.2100@freak.distro.conectiva>
	<20030527200339.GI3767@dualathlon.random>
	<Pine.LNX.4.55L.0305271707370.9487@freak.distro.conectiva>
	<20030527202520.GN3767@dualathlon.random>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 May 2003 22:20:47.0639 (UTC) FILETIME=[39024A70:01C3249E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> However the last numbers from Randy showed my tree going faster than 2.5
> with bonnie and tiotest so I think we don't need to worry and I would
> probably not fix it in a different way in 2.4 even if it would mean a 1%
> degradation.

That could be because -aa quadruples the size of the VM readahead window.

Changes such as that should be removed when assessing the performance
impact of this particular patch.


