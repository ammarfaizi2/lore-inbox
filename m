Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313109AbSDDDBX>; Wed, 3 Apr 2002 22:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313104AbSDDDBO>; Wed, 3 Apr 2002 22:01:14 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20277 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S313103AbSDDDBG>; Wed, 3 Apr 2002 22:01:06 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 Boot enhancements, pic 16 4/9
In-Reply-To: <m11ydwu5at.fsf@frodo.biederman.org>
	<a8fls5$mur$1@cesium.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Apr 2002 19:54:28 -0700
Message-ID: <m17knorx5n.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Followup to:  <m11ydwu5at.fsf@frodo.biederman.org>
> By author:    ebiederm@xmission.com (Eric W. Biederman)
> In newsgroup: linux.dev.kernel
> >
> > Linus please apply,
> > 
> > This patch makes not changes to the generated object code.
> > 
> > Instead removes the assumption the code is linked to run at 0.  The
> > binary code is already PIC, this makes the build process the same way,
> > making the build requirements more flexible. 
> > 
> 
> Flexible in what way?

In that the object files generated can be treated as ordinary object
files, instead of needing special treatment.  

Since gas does not have an ASSUME segment directive to tell the
assembler where base addresses point the current code is arguable
broken.  And this patch is a bug fix.

I don't really need this patch but it sure makes life easier.

Eric
