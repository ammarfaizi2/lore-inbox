Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130476AbQKNSKR>; Tue, 14 Nov 2000 13:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130440AbQKNSKH>; Tue, 14 Nov 2000 13:10:07 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:53768 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S129793AbQKNSJz>; Tue, 14 Nov 2000 13:09:55 -0500
Date: Tue, 14 Nov 2000 18:39:53 +0100
From: Jan Kara <jack@suse.cz>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Used space in bytes
Message-ID: <20001114183953.F8707@atrey.karlin.mff.cuni.cz>
In-Reply-To: <C61D06525A1@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <C61D06525A1@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Thu, Nov 09, 2000 at 07:31:48PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello.

> On  9 Nov 00 at 19:18, Jan Kara wrote:
> > used (I tried to contact Ulrich Drepper <drepper@redhat.com> who should
> > be right person to ask about such things (at least I was said so) but go
> > no answer...). Does anybody have any better solution?
> >   I know about two others - really ugly ones:
> >    1) fs specific ioctl()
> >    2) compute needed number of bytes from st_size and st_blocks, which is
> >       currently possible but won't be in future
> 
> If I may, please do not add it into stat/stat64 structure. On Netware, 
> computing really used space can take eons because of it has to read 
> allocation tables to memory to find size. It is usually about 500% 
> slower than retrieving all other file informations.
  And how do you fill in st_blocks field?

							Honza

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
