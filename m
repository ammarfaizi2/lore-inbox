Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282590AbRKZWBd>; Mon, 26 Nov 2001 17:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282591AbRKZWBX>; Mon, 26 Nov 2001 17:01:23 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:7438 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S282590AbRKZWBH>; Mon, 26 Nov 2001 17:01:07 -0500
Date: Mon, 26 Nov 2001 17:01:05 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Brian Raymond <braymond@fvc.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Async UDP I/O?
Message-ID: <20011126170105.A15582@redhat.com>
In-Reply-To: <6A5AF4EA59EB214BB0267741CE2C86EF0E07F5@neptune.cuseeme.com> <E168TX1-00070O-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E168TX1-00070O-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Nov 26, 2001 at 09:43:15PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 09:43:15PM +0000, Alan Cox wrote:
> What do you mean by "asynchronous UDP" - all UDP is asynchronous. You ask
> it to send it and it gets queued or dropped somewhere - its not subject
> to flow control like TCP
> 
> Can you explain more ?

Async receive helps a lot when you've got tons of open sockets (needed to 
get queuing right).  I think that the current tx mechanism is broken; it's 
quite useful to get backpressure from network devices for things like mlppp 
implemented the right way (as a network protocol, instead of its own layer).

		-ben
