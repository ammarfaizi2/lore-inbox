Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278392AbRJSNqo>; Fri, 19 Oct 2001 09:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278413AbRJSNqZ>; Fri, 19 Oct 2001 09:46:25 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:2587 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S278392AbRJSNqV>; Fri, 19 Oct 2001 09:46:21 -0400
Date: Fri, 19 Oct 2001 15:46:54 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Giuliano Pochini <pochini@shiny.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Poor floppy performance in kernel 2.4.10
Message-ID: <20011019154654.C8408@athlon.random>
In-Reply-To: <20011018194415.S12055@athlon.random> <XFMail.20011019095006.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <XFMail.20011019095006.pochini@shiny.it>; from pochini@shiny.it on Fri, Oct 19, 2001 at 09:50:06AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2001 at 09:50:06AM +0200, Giuliano Pochini wrote:
> 
> > Indeed, only 2.2 trusted the check media change information and left the
> > cache valid on top of the floppy across close/open of the blkdev.
> 
> Which is not a bad thing IMHO, but it can cause problems with
> some broken SCSI implementation where the drive doesn't send
> UNIT_ATTENTION after a media change (like my MO drive when I
> misconfigured the jumpers, damn :-((( ).

Yes, I was aware of that. We'd need a kind of "media change enabler"
bitflag in each lowlevel driver, to implement a blacklist (or whitelist
if you feel safer) that will tell us if to trust the media change info
or not.

Ciao,
Andrea
