Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317054AbSGNTwa>; Sun, 14 Jul 2002 15:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317056AbSGNTw3>; Sun, 14 Jul 2002 15:52:29 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:19653 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S317054AbSGNTw3>; Sun, 14 Jul 2002 15:52:29 -0400
Date: Sun, 14 Jul 2002 21:13:01 +0200
From: Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>
To: Joerg Schilling <schilling@fokus.gmd.de>
Cc: andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Message-ID: <20020714211301.A1858@linux-m68k.org>
References: <200207141418.g6EEIbJp019125@burner.fokus.gmd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200207141418.g6EEIbJp019125@burner.fokus.gmd.de>; from schilling@fokus.gmd.de on Sun, Jul 14, 2002 at 04:18:37PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2002 at 04:18:37PM +0200, Joerg Schilling wrote:
 
> For a starter, it is easier to understand the SCSI concept of
> addressing than to understand the Linux concept. In addition,
> the SCSI addressing concept can be used on different platforms
> in a unique way. This helps people (and GUI writers) to use 
> cdrecord on more than Linux only.

whether it is easier is matter of taste, however in a situation
where the kernel and 99% of other applications refer to something
as '/dev/scd0' I fail to see any benefit of having another scheme.
Do you want to suggest that all other Linux apps should now use
'-dev x,y,z' instead of normal device names?

There is another problem, with your scsi transport library you
are bypassing normal Linux devices. Try
  mount /dev/scd0 /mnt
  cdrecord -dev 0,0,0 -blank=fast
  ls -al /mnt

Nice? It certainly isn't the fault of Linux if you choose to
bypass normal device usage and it can be very annoying not
only for beginners.

Richard

