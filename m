Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129765AbRADTXm>; Thu, 4 Jan 2001 14:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130650AbRADTXc>; Thu, 4 Jan 2001 14:23:32 -0500
Received: from zeus.kernel.org ([209.10.41.242]:27404 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129765AbRADTX0>;
	Thu, 4 Jan 2001 14:23:26 -0500
Date: Thu, 4 Jan 2001 19:21:04 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Daniel Phillips <phillips@innominate.de>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
Message-ID: <20010104192104.C2034@redhat.com>
In-Reply-To: <Pine.LNX.4.30.0101031253130.6567-100000@springhead.px.uk.com> <Pine.LNX.4.21.0101031325270.1403-100000@duckman.distro.conectiva> <3A5352ED.A263672D@innominate.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5352ED.A263672D@innominate.de>; from phillips@innominate.de on Wed, Jan 03, 2001 at 05:27:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 03, 2001 at 05:27:25PM +0100, Daniel Phillips wrote:
> 
> Tux2 is explicitly designed to legitimize pulling the plug as a valid
> way of shutting down.  Metadata-only journalling filesystems are not
> designed to be used this way, and even with full-data journalling you
> should bear in mind that your on-disk filesystem image remains in an
> invalid state until the journal recovery program has run successfully. 

ext3 does the recovery automatically during mount(8), so user space
will never see an unrecovered filesystem.  (There are filesystem flags
set by the journal code to make sure that an unrecovered filesystem
never gets mounted by a kernel which doesn't know how to do the
appropriate recovery.)

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
