Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273184AbTG3SKO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 14:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273186AbTG3SKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 14:10:13 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:18752 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S273184AbTG3SKK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 14:10:10 -0400
Date: Wed, 30 Jul 2003 21:10:03 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, gibbs@scsiguy.com
Subject: Re: 2.4.22pre8 hangs too (Re: 2.4.21-jam1, aic7xxx-6.2.36: solid hangs)
Message-ID: <20030730181003.GC204962@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, gibbs@scsiguy.com
References: <20030729073948.GD204266@niksula.cs.hut.fi> <20030730071321.GV150921@niksula.cs.hut.fi> <Pine.LNX.4.55L.0307301149550.29648@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0307301149550.29648@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 11:50:50AM -0300, you [Marcelo Tosatti] wrote:
> 
> > Any ideas?
> 
> Ville,
> 
> Mind trying 2.4.22-pre8 without MMAPIO defined in the SCSI driver?

2.4.20pre7 (aic7xxx 6.2.8) that I initially saw the lockups with was
compiled with MMAPIO undefined. 2.4.21-jam1 (aic7xxx 6.2.36) and 2.4.22pre8
(aic7xxx 6.2.36) had it defined (the default). All of the three locked up
the same way. Hence, I think it's unlikely MMAPIO is the culprit.

However, I just realized that all of those kernel were compiled with fairly
dubious gcc, version 2.96-85. I just compiled otherwise identically
configured 2.4.21-jam1 with gcc-3.2.1-2. It'll take some time to tell
whether this cures it. This is my main suspect now.
 
> Justin, is this problem known to other boards or.. ?

The lockups may be completely unrelated to aic7xxx and the crashes on boot
that I posted kernel logs of. I don't know.


-- v --

v@iki.fi
