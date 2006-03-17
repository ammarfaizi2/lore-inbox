Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752482AbWCQBME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482AbWCQBME (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 20:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752486AbWCQBMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 20:12:03 -0500
Received: from mail.gmx.de ([213.165.64.20]:65153 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1752480AbWCQBL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 20:11:57 -0500
Date: Fri, 17 Mar 2006 02:11:55 +0100 (MET)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       janak@us.ibm.com, viro@ftp.linux.org.uk, hch@lst.de, ak@muc.de,
       paulus@samba.org
MIME-Version: 1.0
References: <Pine.LNX.4.64.0603161555210.3618@g5.osdl.org>
Subject: =?ISO-8859-1?Q?Re:_[PATCH]_unshare:_Cleanup_up_the_sys=5Funshare_interfac?=
 =?ISO-8859-1?Q?e_before_we_are_committed.?=
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <29085.1142557915@www064.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

> On Fri, 17 Mar 2006, Michael Kerrisk wrote:
> > > 
> > > My personal opinion is that having a different set of flags is more 
> > > confusing 
> > 
> > How is it confusing?  And who is it confusing for?
> 
> It's confusing because
>  - it's just more flags to keep track of

Agreed, there is a "confusion cost" to that.

>  - it's all the same issues that clone() has

At the moment, but possibly not in the future (if one day
usnhare() needs a flag that has no analogue in clone()).

>  - it's an opportunity for future incoherence

Not sure what future incoherence you mean here.  Anyway,
we inject some incoherence *now* (some unshare() flags reverse
their clone() counterparts, one does not).

> > It will potentially require kernel developers to think for just 
> > a moment about what is going on.  But why care about them -- 
> > they don't have to *use* this interface; userland programmers do.
> 
> All the confusion is equally a userland issue, don't try to just enforce 
> your own opinions as somehow being "facts" by repeating them over 
> and over again.

I'm not trying to do that.  I've repeated my statements 
because I haven't seen any clear counterarguments.  I have a
particular opinion about what constitutes confusion, and it
comes from a perspective that focuses on the kernel-userland 
interface.  I agree that it does create some "confusion cost"
for userland programmers to add new flags.  But _in my opinion_
that cost is outweighed by the greater "confusion costs" that
I have described.  Eric seemed to agree.  Unfortunately for my
argument, you and Janak don't ;-).

Cheers,

Michael

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
