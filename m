Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262200AbVATQuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbVATQuF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 11:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbVATQrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 11:47:48 -0500
Received: from mail.joq.us ([67.65.12.105]:33179 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262200AbVATQqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 11:46:17 -0500
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt
 scheduling
References: <200501201542.j0KFgOwo019109@localhost.localdomain>
From: "Jack O'Quin" <joq@io.com>
Date: Thu, 20 Jan 2005 10:47:38 -0600
In-Reply-To: <200501201542.j0KFgOwo019109@localhost.localdomain> (Paul
 Davis's message of "Thu, 20 Jan 2005 10:42:24 -0500")
Message-ID: <87y8eo9hed.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Davis <paul@linuxaudiosystems.com> writes:

>>That's discouraging about reiserfs.  Is it version 3 or 4?  Earlier
>>versions showed good realtime responsiveness for audio testers.  It
>>had a reputation for working much better at lower latency than ext3.
>
> over on #ardour last week, we saw appalling performance from
> reiserfs. a 120GB filesystem with 11GB of space failed to be able to
> deliver enough read/write speed to keep up with a 16 track
> session. When the filesystem was cleared to provide 36GB of space,
> things improved. The actual recording takes place using writes of
> 256kB, and no more than a few hundred MB was being written during the
> failed tests.
>
> everything i read about reiser suggests it is unsuitable for audio
> work: it is optimized around the common case of filesystems with many
> small files. the filesystems where we record audio is typically filled
> with a relatively small number of very, very large files.

I was not speaking of its disk performance, but rather of low-latency
CPU performance.  In 2.4 with the low-latency patches, reiserfs did
that fairly well.

I know its design is not focused on streaming large blocks of data to
disk.  But, when you're recording clicks every 20 seconds, disk
throughput is definitely a secondary consideration.

Looks like we need to do another study to determine which filesystem
works best for multi-track audio recording and playback.  XFS looks
promising, but only if they get the latency right.  Any experience
with that?
-- 
  joq
