Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAEAe3>; Thu, 4 Jan 2001 19:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129415AbRAEAeT>; Thu, 4 Jan 2001 19:34:19 -0500
Received: from hermes.mixx.net ([212.84.196.2]:37894 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129348AbRAEAeD>;
	Thu, 4 Jan 2001 19:34:03 -0500
Message-ID: <3A5515D0.7F21E668@innominate.de>
Date: Fri, 05 Jan 2001 01:31:12 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-prerelease i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
In-Reply-To: <Pine.LNX.4.30.0101031253130.6567-100000@springhead.px.uk.com> <Pine.LNX.4.21.0101031325270.1403-100000@duckman.distro.conectiva> <3A5352ED.A263672D@innominate.de> <20010104192104.C2034@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" wrote:
> 
> On Wed, Jan 03, 2001 at 05:27:25PM +0100, Daniel Phillips wrote:
> >
> > Tux2 is explicitly designed to legitimize pulling the plug as a valid
> > way of shutting down.  Metadata-only journalling filesystems are not
> > designed to be used this way, and even with full-data journalling you
> > should bear in mind that your on-disk filesystem image remains in an
> > invalid state until the journal recovery program has run successfully.
> 
> ext3 does the recovery automatically during mount(8), so user space
> will never see an unrecovered filesystem.  (There are filesystem flags
> set by the journal code to make sure that an unrecovered filesystem
> never gets mounted by a kernel which doesn't know how to do the
> appropriate recovery.)

Hi Stephen.

Yes, and so long as your journal is not on another partition/disk things
will eventually be set right.  The combination of a partially updated
filesystem and its journal is in some sense a complete, consistent
filesystem.

I'm curious - how does ext3 handle the possibility of a crash during
journal recovery?

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
