Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161105AbWJPVj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161105AbWJPVj7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 17:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422840AbWJPVj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 17:39:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:9523 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161105AbWJPVj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 17:39:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cM3kbJwaPudvahwcB/f2/Emz1WDLOEFjRdCMJ/yttJBxbXh5XFqLaZNPHASK/okJa+scz1ssZm5Dc0JKG7MQCytqBBx8oqTz7l9JxKmmUe6hcLF/hsFFeIh1GPULBUsq8HXvnBD0aBwbiqsCo20PKw3km3rZhWWYTsZd3cyTMLI=
Message-ID: <9a8748490610161439o408217f6mb4928d92f93f679d@mail.gmail.com>
Date: Mon, 16 Oct 2006 23:39:55 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: BUG: spinlock lockup - during shutdown - umount && pdflush implicated.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got a few "BUG: spinlock lockup" messages while trying to
reboot my box (shutdown -r now).

Unfortunately all I had available to capture the situation was a
crappy camera phone, so all I have are some bad quality jpeg images.
I've put the images up here:
  ftp://ftp.kernel.org/pub/linux/kernel/people/juhl/images/screenshot0.jpg
  ftp://ftp.kernel.org/pub/linux/kernel/people/juhl/images/screenshot1.jpg
  ftp://ftp.kernel.org/pub/linux/kernel/people/juhl/images/screenshot2.jpg

The kernel I was running was one generated during a "git bisect"
session, but unfortunately I no longer know exactely where in the
session it was from. All I know is that it is somewhere between 2.6.18
and 2.6.19-rc1.

It happened shortly after I did a alt+sysrq+t (which I did since I was
wondering why it was taking ages to unmount my local filesystems) -
these BUG messages showed up roughly 4 or 5 seconds after that.

I've tried to reproduce it, but without luck.

I'm just hoping that someone can spot something obvious from the
messages. I don't have a clue on this one.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
