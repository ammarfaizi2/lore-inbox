Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266113AbUFQDC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266113AbUFQDC6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 23:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266084AbUFQDC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 23:02:58 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:15629 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S266113AbUFQDCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 23:02:48 -0400
To: Daniel Pittman <daniel@rimspace.net>
Cc: linux-kernel@vger.kernel.org, Ext3-users@redhat.com
From: Tim Connors <tconnors+linuxkernel1087440971@astro.swin.edu.au>
Subject: Re:  mode data=journal in ext3. Is it safe to use?
In-reply-to: <871xkfroph.fsf@enki.rimspace.net>
References: <40FB8221D224C44393B0549DDB7A5CE83E31B1@tor.lokal.lan> <1087322976.1874.36.camel@pla.lokal.lan> <40D06C0B.7020005@techsource.com> <871xkfroph.fsf@enki.rimspace.net>
X-Face: m+g#A-,3D0}Ygy5KUD`Hckr=I9Au;w${NzE;Iz!6bOPqeX^]}KGt=l~r!8X|W~qv'`Ph4dZczj*obWD25|2+/a5.$#s23k"0$ekRhi,{cP,CUk=}qJ/I1acc
Message-ID: <slrn-0.9.7.4-20571-31157-200406171256-tc@hexane.ssi.swin.edu.au>
Date: Thu, 17 Jun 2004 13:02:30 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Pittman <daniel@rimspace.net> said on Thu, 17 Jun 2004 10:51:54 +1000:
> XFS, with the "null out data on recovery" mode, is less reliable than
> ext3, full stop. It routinely destroys data in real world situations, a
> secure, but irritating, choice.

And please tell me -- the point of journalling is to reduce fsck times
upon failure - particularly important if you have 14TB of raid (yes,
we had to fsck after a recent downtime, and it had been > 180 days -
took half the day). What is the point of journalling if you have to
compare and restore against backup everytime the power fails? This is
slower than a mere fsckage.

FYI, I think jfs has the same behaviour as xfs - I do notice a
distinct lack of usage of a /lost+found, which has been important to
me in the past.

> ext3 remains the only journaling filesystem that I would, personally,
> put any great degree of faith in, since it is still developed in a
> cautious and safe fashion, and has a focus on getting the tools to
> verify correctness in place before enabling kernel-side features.
> 
> 
> Obviously, your millage may vary on these topics, as presumably have
> your experiences.

Sounds about right :)

Next time I reformat/get a new drive, I'll be going back to ext3 -
never caused any problems for me.

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
Single White Stick-Figure, L12, enjoys long walks by the shore,
cooking up a nice menudo, and bashing small animals with sticks. My
meat sword is enormous. Seeks female Accordian Thief for relationship
and buffs.               -- Riff @ some game forum
