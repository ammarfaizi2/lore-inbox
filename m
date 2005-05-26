Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVEZSRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVEZSRV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 14:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVEZSRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 14:17:21 -0400
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:62362 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S261675AbVEZSRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 14:17:17 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.12-rc5-mm1 alsa oops
Date: Thu, 26 May 2005 20:12:45 +0200
User-Agent: KMail/1.7.2
Cc: pharon@gmail.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <1117092768.26173.4.camel@localhost> <200505261944.50942.petkov@uni-muenster.de> <1117130470.5477.5.camel@mindpipe>
In-Reply-To: <1117130470.5477.5.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505262012.45833.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 May 2005 20:01, Lee Revell wrote:
> On Thu, 2005-05-26 at 19:44 +0200, Borislav Petkov wrote:
> > <snip>
> >
> > Andrew,
> >
> > similar oopses as the one I'm replying to all over the place. At it
> > happens m in snd_pcm_mmap_data_close(). Here's a stack trace:
>
> No one using ALSA CVS or any of the 1.0.9 release candidates ever
> reported this, but lots of -mm users are... does that help at all?  I
> suspect some upstream bug that ALSA just happens to trigger.
yeah,

this has to do with alsa indirectly. snd_pcm_mmap_data_close() accesses some 
vm_area_struct->vm_private_data and apparently there have been some 
optimizations to mmap code to avoid fragmentation of vma's so i think there's 
the problem. However, we'll need the smarter ones here :))

Regards,
Boris.
