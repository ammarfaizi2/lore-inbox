Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVATRx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVATRx2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 12:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVATRua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 12:50:30 -0500
Received: from jose.lug.udel.edu ([128.175.60.112]:63676 "HELO
	mail.lug.udel.edu") by vger.kernel.org with SMTP id S261362AbVATRtn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 12:49:43 -0500
From: ross@lug.udel.edu
Date: Thu, 20 Jan 2005 12:49:39 -0500
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: "Jack O'Quin" <joq@io.com>, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
Message-ID: <20050120174939.GA15920@jose.lug.udel.edu>
References: <87pt00b01i.fsf@sulphur.joq.us> <200501201542.j0KFgOwo019109@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501201542.j0KFgOwo019109@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 10:42:24AM -0500, Paul Davis wrote:
> over on #ardour last week, we saw appalling performance from
> reiserfs. a 120GB filesystem with 11GB of space failed to be able to
> deliver enough read/write speed to keep up with a 16 track
> session. When the filesystem was cleared to provide 36GB of space,
> things improved. The actual recording takes place using writes of
> 256kB, and no more than a few hundred MB was being written during the
> failed tests.

It's been a long while since I followed ReiserFS development closely,
*however*, this issue used to be a common problem ReiserFS - when
free space starts to drop below 10%, performace takes a big hit.  So
performance improved when space was cleared up.

I don't remember what causes this or what the status is in modern
ResierFS systems.

> everything i read about reiser suggests it is unsuitable for audio
> work: it is optimized around the common case of filesystems with many
> small files. the filesystems where we record audio is typically filled
> with a relatively small number of very, very large files.

Anecdotally, I've found this to not be the case.  I only use ReiserFS
and have a few reasonably sized projects in Ardour that work fine:
maybe 20 tracks, with 10-15 plugins (in the whole project), and I can
do overdubs with no problems.  It may be relevant that I only have a
four track card and so load is too small.

But at least in my practice, it hasn't been a huge hinderance.

-- 
Ross Vandegrift
ross@lug.udel.edu

"The good Christian should beware of mathematicians, and all those who
make empty prophecies. The danger already exists that the mathematicians
have made a covenant with the devil to darken the spirit and to confine
man in the bonds of Hell."
	--St. Augustine, De Genesi ad Litteram, Book II, xviii, 37
