Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317450AbSHBA2M>; Thu, 1 Aug 2002 20:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317484AbSHBA2M>; Thu, 1 Aug 2002 20:28:12 -0400
Received: from pcp809445pcs.nrockv01.md.comcast.net ([68.49.82.129]:55686 "EHLO
	zalem.puupuu.org") by vger.kernel.org with ESMTP id <S317450AbSHBA2L>;
	Thu, 1 Aug 2002 20:28:11 -0400
Date: Thu, 1 Aug 2002 20:31:40 -0400
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: manipulating sigmask from filesystems and drivers
Message-ID: <20020801203140.A3166@zalem.puupuu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208020009490.28515-100000@serv> <Pine.LNX.4.33.0208011613440.1315-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0208011613440.1315-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Aug 01, 2002 at 04:30:40PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 04:30:40PM -0700, Linus Torvalds wrote:
> And yes, these logging programs are mission-critical, and they do have
> signals going on, and they rely on well-defined and documented interfaces
> that say that doing a write() to a filesystem is _not_ going to return in
> the middle just because a signal came in.

How hard and/or insane would it be to somehow special-case SIGKILL?
It is a tad annoying not to be able to get rid of D state processes,
especially ones blocking unmounts because the filesystem is busy.

Of course, an alternative is a real, brutal, forced unmount that
leaves a clean filesystem and dead/dying processes.

  OG.
