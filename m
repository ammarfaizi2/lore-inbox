Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318759AbSG0NyH>; Sat, 27 Jul 2002 09:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318760AbSG0NyH>; Sat, 27 Jul 2002 09:54:07 -0400
Received: from dsl-213-023-021-146.arcor-ip.net ([213.23.21.146]:55015 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318759AbSG0NyG>;
	Sat, 27 Jul 2002 09:54:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jesse Barnes <jbarnes@sgi.com>, martin@dalecki.de
Subject: Re: [PATCH] lock assertion macros for 2.5.28
Date: Sat, 27 Jul 2002 15:59:00 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <20020725233047.GA782991@sgi.com> <3D40DA00.9080603@evision.ag> <20020726174039.GB793866@sgi.com>
In-Reply-To: <20020726174039.GB793866@sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17YS61-0005Ke-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 July 2002 19:40, Jesse Barnes wrote:
> On Fri, Jul 26, 2002 at 07:11:28AM +0200, Marcin Dalecki wrote:
> > Well one one place? Every single implementation of the request_fn
> > method from the request_queue_t needs to hold some
> > lock associated with the queue in question.
> > 
> > In fact you will find ASSERT_LOCK macros sparnkled through the scsi code 
> > already right now. BTW> ASSERT_HOLDS would sound a bit more
> > familiar to some of us.
> > 
> > This minor issue asside I think that your idea is a good thing.
> 
> Thanks for the pointer.  I'll change those assertions over in the
> next revision.

The scsi version is not the same, it's going to need to be changed to
this sensible version.

The original name is better and shorter.  I doubt there is anybody who
will not know immediately what MUST_HOLD(&lock) means.

-- 
Daniel
