Return-Path: <linux-kernel-owner+w=401wt.eu-S1030195AbXADTal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbXADTal (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 14:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbXADTal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 14:30:41 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:40223 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030195AbXADTak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 14:30:40 -0500
Message-ID: <459D55E3.4000905@drzeus.cx>
Date: Thu, 04 Jan 2007 20:30:43 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: NCPFS and brittle connections
References: <459D1794.2060009@drzeus.cx> <459D38DA.4030803@vc.cvut.cz>
In-Reply-To: <459D38DA.4030803@vc.cvut.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
>
> Nobody is working on it (at least to my knowledge), and to me it is
> feature - it always worked this way, like smbfs did back in the past -
> if you send signal 9 to process using mount point, and there is some
> transaction in progress, nobody can correctly finish that transaction
> anymore.  Fixing it would require non-trivial amount of code, and
> given that NCP itself is more or less dead protocol I do not feel that
> it is necessary.
>

Someone needs to tell our customers then so they'll stop using it. :)

> If you want to fix it, feel free.  Culprit is RQ_INPROGRESS handling
> in ncp_abort_request - it just aborts whole connection so it does not
> have to provide temporary buffers and special handling for reply - as
> buffers currently specified as reply buffers are owned by caller, so
> after aborting request you cannot use them anymore.

Do you have any pointers to how it was solved with smbfs? Relevant
patches perhaps? Provided a similar solution can be applied here.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

