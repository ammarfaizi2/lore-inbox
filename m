Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262360AbVGLUKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbVGLUKG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 16:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbVGLUKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 16:10:01 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:65189 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262360AbVGLUJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 16:09:07 -0400
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050711150711.GA19290@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk>
	 <20050709155704.GA14535@elte.hu> <200507091704.12368.s0348365@sms.ed.ac.uk>
	 <200507111455.45105.s0348365@sms.ed.ac.uk> <20050711141232.GA16586@elte.hu>
	 <20050711141622.GA17327@elte.hu>  <20050711150711.GA19290@elte.hu>
Content-Type: text/plain
Date: Tue, 12 Jul 2005 16:09:05 -0400
Message-Id: <1121198946.10580.13.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 17:07 +0200, Ingo Molnar wrote:
> I've uploaded -27 with the fix - but it should 
> only confirm that it's not a stack overflow.

V0.7.51-28 does not compile:

  CC [M]  sound/oss/emu10k1/midi.o
sound/oss/emu10k1/midi.c:48: error: syntax error before '__attribute__'
sound/oss/emu10k1/midi.c:48: error: syntax error before ')' token

Here's the offending line:

    48 static DEFINE_SPINLOCK(midi_spinlock __attribute((unused)));

Lee


