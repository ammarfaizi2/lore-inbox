Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267390AbRGLAzr>; Wed, 11 Jul 2001 20:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267391AbRGLAz1>; Wed, 11 Jul 2001 20:55:27 -0400
Received: from web14402.mail.yahoo.com ([216.136.174.59]:33553 "HELO
	web14402.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267390AbRGLAzW>; Wed, 11 Jul 2001 20:55:22 -0400
Message-ID: <20010712005520.20851.qmail@web14402.mail.yahoo.com>
Date: Wed, 11 Jul 2001 17:55:20 -0700 (PDT)
From: Rajeev Bector <rajeev_bector@yahoo.com>
Subject: Re: new IPC mechanism ideas
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <3B4CF429.D0B3B473@transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If your driver is in the kernel,
then you dont need that. All processes
use system-calls (or ioctls) to send
messages and when they do recv(),
they get a pointer to a location
(where they are mapped to via mmap)
and they can read directly. In this
scheme, you dont need any traditional
UNIX IPC mechanism to work.

Thanks,
Rajeev

--- "H. Peter Anvin" <hpa@transmeta.com> wrote:
> Rajeev Bector wrote:
> > 
> > Thanks for your comment, Peter.
> > The problem with using a "driver"
> > process is that now you need
> > another mechanism to communicate
> > with that driver - either
> > message queues or shared
> > memory or something.
> > 
> 
> You need that anyway.
> 
> 	-hpa


__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail
http://personal.mail.yahoo.com/
