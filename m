Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268156AbUJDOMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268156AbUJDOMo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 10:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268157AbUJDOMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 10:12:44 -0400
Received: from open.hands.com ([195.224.53.39]:57514 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S268156AbUJDOMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 10:12:40 -0400
Date: Mon, 4 Oct 2004 15:23:41 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [bug] 2.6.8: CDROM_SEND_PACKET ioctls failing as non-root on ide scsi drives
Message-ID: <20041004142341.GD20930@lkcl.net>
References: <20041004130941.GE19341@lkcl.net> <6u4qlaehlw.fsf@zork.zork.net> <20041004133610.GT2287@suse.de> <6uu0tad24s.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6uu0tad24s.fsf@zork.zork.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2004 at 02:49:39PM +0100, Sean Neakums wrote:
> Jens Axboe <axboe@suse.de> writes:
> 
> > On Mon, Oct 04 2004, Sean Neakums wrote:
> >> CDROM_SEND_PACKET calls down to sg_io, which calls verify_command,
> >> which will not permit anyone but root to use any unrecognised
> >> commands.  GET CONFIGURATION does not seems to be one of those
> >> recognised.  This check for unrecognised commands is a fairly recent
> >> addition, IIRC.
> >
> > 2.6.8 didn't have any command granularity, you must be root to issue any
> > comand there.
> 
> I was looking at 2.6.8.1 when I wrote the above, although it's
> possible my eye skipped over something.
 
  ah yes now i have found the issue i have a confession to make,
  i'm actually running 2.6.8.1-selinux1.

  i didn't want to mention that in case it was selinux that was the
  problem :)

  l.
