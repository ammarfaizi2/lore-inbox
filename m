Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317340AbSGXOpP>; Wed, 24 Jul 2002 10:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317380AbSGXOpP>; Wed, 24 Jul 2002 10:45:15 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:54159 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317340AbSGXOpO>;
	Wed, 24 Jul 2002 10:45:14 -0400
Date: Wed, 24 Jul 2002 16:48:18 +0200
From: Jens Axboe <axboe@suse.de>
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DAC960 Bitrot
Message-ID: <20020724144818.GU15201@suse.de>
References: <Pine.LNX.4.44L.0207101741380.14432-100000@imladris.surriel.com> <E17Sai1-0002T7-00@starship> <20020711100828.GE808@suse.de> <E17WlGV-00052g-00@starship> <20020724143931.GG5159@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020724143931.GG5159@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24 2002, Jens Axboe wrote:
> Hmm, is DAC960 using a full major per controller?!

Yep it is, ok so it was always using per-controller queues by virtue of
that. So you'll just need to add a lock to Controller, not the queue
itself. On second thought, please add the queue as well though. Maybe we
can kill BLK_DEFAULT_QUEUE() sometime soon then :-)

-- 
Jens Axboe

