Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282482AbSAARjx>; Tue, 1 Jan 2002 12:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282418AbSAARjn>; Tue, 1 Jan 2002 12:39:43 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19973 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S281926AbSAARje>;
	Tue, 1 Jan 2002 12:39:34 -0500
Date: Tue, 1 Jan 2002 18:39:02 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
        linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: "sr: unaligned transfer" in 2.5.2-pre1
Message-ID: <20020101183902.A16092@suse.de>
In-Reply-To: <20011231145455.C6465@one-eyed-alien.net> <Pine.LNX.4.10.10112311523040.4780-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10112311523040.4780-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31 2001, Andre Hedrick wrote:
> 
> Matt,
> 
> This was a point I tried to make but failed.
> Not all SCB/SRB's are highmem tested but OEM's claim support.
> This I tried to have BIO change to do highmen drop to the lowmem window
> upon entry of the request and this would have prevent most form breaking,
> but this did not seem to get warm acceptance.

default behaviour is to bounce any highmem page, nothings changed there.

if you are talking about mapping highmem pages temporarily like
mentioned in an email a few days back, then that's clearly a bad idea.

-- 
Jens Axboe

