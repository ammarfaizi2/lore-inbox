Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289741AbSBSEyl>; Mon, 18 Feb 2002 23:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289762AbSBSEyb>; Mon, 18 Feb 2002 23:54:31 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45392 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S289639AbSBSEyW>; Mon, 18 Feb 2002 23:54:22 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: penguin@wombat.ca (Craig), linux-kernel@vger.kernel.org
Subject: Re: Serial Console changes in linux 2.4.15??
In-Reply-To: <E16cwTv-00073S-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 18 Feb 2002 21:49:53 -0700
In-Reply-To: <E16cwTv-00073S-00@the-village.bc.nu>
Message-ID: <m1d6z23wjy.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > If i manually put the lines back (the "#if 0" and "#endif"), then my serial
> > console works just fine.
> 
> Except that you broke serial support for CREAD control
> 
> > Did someone submit serial.c with the "#if 0" lines removed by accident?
> 
> No
> 
> > My other question is: Why does this break the serial console?
> 
> Your user space is buggy I think, and didn't set CREAD

Old versions of /sbin/init are broken and clear CREAD.  Most getty's (except
mingetty) do the right thing.  I saw the change at 2.4.2 -> 2.4.3.  I
don't why some people have managed to avoid it for longer periods of
time.

The great mystery is how /sbin/init managed to work in 2.4.2....

Eric
