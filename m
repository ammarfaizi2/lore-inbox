Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbVATPqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbVATPqf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 10:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVATPn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 10:43:56 -0500
Received: from out005pub.verizon.net ([206.46.170.143]:57757 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S262167AbVATPmf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 10:42:35 -0500
Message-Id: <200501201542.j0KFgOwo019109@localhost.localdomain>
To: "Jack O'Quin" <joq@io.com>
cc: Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling 
In-reply-to: Your message of "Thu, 20 Jan 2005 09:19:37 CST."
             <87pt00b01i.fsf@sulphur.joq.us> 
Date: Thu, 20 Jan 2005 10:42:24 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.197.206.140] at Thu, 20 Jan 2005 09:42:26 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>That's discouraging about reiserfs.  Is it version 3 or 4?  Earlier
>versions showed good realtime responsiveness for audio testers.  It
>had a reputation for working much better at lower latency than ext3.

over on #ardour last week, we saw appalling performance from
reiserfs. a 120GB filesystem with 11GB of space failed to be able to
deliver enough read/write speed to keep up with a 16 track
session. When the filesystem was cleared to provide 36GB of space,
things improved. The actual recording takes place using writes of
256kB, and no more than a few hundred MB was being written during the
failed tests.

everything i read about reiser suggests it is unsuitable for audio
work: it is optimized around the common case of filesystems with many
small files. the filesystems where we record audio is typically filled
with a relatively small number of very, very large files.

--p
