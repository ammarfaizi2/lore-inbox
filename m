Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261871AbSJNIrM>; Mon, 14 Oct 2002 04:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261875AbSJNIrM>; Mon, 14 Oct 2002 04:47:12 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:14994 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261871AbSJNIrL> convert rfc822-to-8bit; Mon, 14 Oct 2002 04:47:11 -0400
Message-ID: <3DAA85D8.70D9FF25@folkwang-hochschule.de>
Date: Mon, 14 Oct 2002 10:52:40 +0200
From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-audio-dev@music.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] latency performance of 2.4 and 2.5...
References: <3DA6C8A3.2892656@folkwang-hochschule.de> <3DAA7E8F.36B03682@folkwang-hochschule.de> <3DAA8200.2AF20C5C@digeo.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Joern Nettingsmeier wrote:
> >
> > some new interesting results with 2.5.42:
> >
> > http://spunk.dnsalias.org/latencytest/2.5.42/2x256.html
> >
> > overall much worse, *but* greatly reduced latency peaks (max. 6 ms) as
> > compared to 2.5.41:
> >
> > http://spunk.dnsalias.org/latencytest/2.5.41/2x256.html
> >
> > here the peaks easily reach 13 ms.
> 
> Rather depends on the filesystem.  ext3 does its own write scheduling,
> and does stuff inside lock_kernel().  It needs a couple of scheduling
> points I guess.
> 
> I'd expect ext2 to work OK with preemption, but nobody has really
> looked yet.  Unless you're using ftruncate() (grr.)

oh, i should have stated i'm using reiserfs on /, /usr and /var (var
being a softraid-0).


-- 
Jörn Nettingsmeier     
Kurfürstenstr 49, 45138 Essen, Germany      
http://spunk.dnsalias.org (my server)
http://www.linuxdj.com/audio/lad/ (Linux Audio Developers)
