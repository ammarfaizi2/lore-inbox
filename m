Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWEWSUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWEWSUx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWEWSUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:20:53 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:49250 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751169AbWEWSUx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:20:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iqyBDPpugbfV3vv98s7KHvH43vIXkoAI85augYvfGTphfg7CzCFEWLbHzJSmMBNzDC9EcZDiBu6L3LwbYjXFY/mIH11BukuwqlUR5Ubw7IuqHKXVbtVPXA0wDzRq98AC0V0ljrgYQkJ6kvJBZ7xZ2YVm6djnzmfTLKm+1q5biNI=
Message-ID: <aa4c40ff0605231120l183268dbu848e081e5c564b4a@mail.gmail.com>
Date: Tue, 23 May 2006 11:20:52 -0700
From: "James Lamanna" <jlamanna@gmail.com>
To: "Kai Makisara" <Kai.Makisara@kolumbus.fi>
Subject: Re: Sense data errors trying to read from tape - 2.6.14-gentoo-r5
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0605232108300.5791@kai.makisara.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <aa4c40ff0605230822r34230211o9fa276234545dd59@mail.gmail.com>
	 <Pine.LNX.4.63.0605232108300.5791@kai.makisara.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/06, Kai Makisara <Kai.Makisara@kolumbus.fi> wrote:
> On Tue, 23 May 2006, James Lamanna wrote:
>
> > On 5/23/06, James Lamanna <jlamanna@gmail.com> wrote:
> > > Was trying to do an 'amrestore /dev/nst0' when I received the following
> > > OOPS:
> > >
> >
> > [SNIP]
> >
> > > I've also had problems restoring large XFS partitions off of tape
> > > (amrestore returns with input/output errors), but I'm not sure whether
> > > that is kernel or userspace related (no errors in dmesg or anything).
> > > In that case, amrestore did not have any problems restoring TAR-ed
> > > filesystems from tape (that was with 2.6.14-gentoo-r5).
> > >
> >
> > [SNIP]
> >
> > As a follow-up to the above on 2.6.14-gentoo-r5, while trying to
> > restore an XFS partition off of the tape (amrestore/dd doesn't oops on
> > this kernel) my dmesg fills with the following:
> >
> > st0: Error with sense data: <6>st0: Current: sense key=0xb
> >    ASC=0x4b ASCQ=0x0
> >
> The sense key is "Aborted Command". The ASC and ASCQ fields translate to
> "Data phase error".
>
> My first guess is that there are SCSI bus problems (cabling, termination,
> etc.).

The strange part about this is that I only notice these input output
errors while reading a large XFS dumpfile off of the tape. Reading the
TARed dumpfiles always seems to work fine, even when they are on the
same tape!

I'm hoping to boot with vanilla 2.6.16.18 later tonight to see if I
still have that OOPS I reported earlier also.

>
> --
> Kai
>

-- James
