Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262232AbVAUA34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbVAUA34 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 19:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbVAUA34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 19:29:56 -0500
Received: from mail.joq.us ([67.65.12.105]:37050 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262230AbVAUA3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 19:29:32 -0500
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt
 scheduling
References: <200501201542.j0KFgOwo019109@localhost.localdomain>
	<87y8eo9hed.fsf@sulphur.joq.us>
	<16880.10712.159729.934973@wombat.chubb.wattle.id.au>
From: "Jack O'Quin" <joq@io.com>
Date: Thu, 20 Jan 2005 18:30:31 -0600
In-Reply-To: <16880.10712.159729.934973@wombat.chubb.wattle.id.au> (Peter
 Chubb's message of "Fri, 21 Jan 2005 08:59:52 +1100")
Message-ID: <87oefj39p4.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb <peterc@gelato.unsw.edu.au> writes:

>>>>>> "Jack" == Jack O'Quin <joq@io.com> writes:
>
> Jack> Looks like we need to do another study to determine which
> Jack> filesystem works best for multi-track audio recording and
> Jack> playback.  XFS looks promising, but only if they get the latency
> Jack> right.  Any experience with that?  
>
> The nice thing about audio/video and XFS is that if you know ahead of
> time the max size of a file (and you usually do -- because you know
> ahead of time how long a take is going to be) you can precreadte the
> file as a contiguous chunk, then just fill it in, for minimum disc
> latency.

I am not talking about disk latency.  The problem Con uncovered in
ReiserFS was CPU hogging.  Every 20 seconds there was a 6msec latency
glitch in system response.
-- 
  joq
