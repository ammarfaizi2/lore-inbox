Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWGMPlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWGMPlJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 11:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWGMPlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 11:41:09 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:14687 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S964785AbWGMPlI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 11:41:08 -0400
In-Reply-To: <44B65924.7060602@us.ibm.com>
Subject: Re: [PATCH] s390 hypfs fixes for 2.6.18-rc1-mm1
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OFABC483F9.1D9AD47C-ON422571AA.0056247F-422571AA.0056297A@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Thu, 13 Jul 2006 17:41:07 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.5.5HF268 | April 6, 2006) at
 13/07/2006 17:44:02
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote on 07/13/2006 04:31:00 PM:
> Andrew Morton wrote:
> > On Wed, 12 Jul 2006 21:17:53 -0700
> > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >

[snip]

> >
> > err, "temporary" things tend to become permanent.  What's the real fix?
> >
> I am not sure, if we really need to vectorize this method or not -
> meaning will this be ever called
> with more than one items in the vector.
>
> Micheal, is it possible ? Can some one directly use AIO interface on
> hypfs ? If not, we can always
> look at only first element and ignore rest of them. Otherwise, we need
> to iterate on all the elements
> of the vector.

Of course it is possible that someone uses AIO on hypfs files, but
normally the synchronous IO functions are used. I used the AIO
implementation together with do_sync_read/write() only because
it was not more effort regarding the implementation and we got
the AIO interface for free.

Nevertheless we probably should implement the complete
function.

Michael

