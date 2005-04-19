Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVDSL5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVDSL5Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 07:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVDSL5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 07:57:24 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:56164 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261461AbVDSL5T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 07:57:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VWmBUgaf/yducJone3mvHmaHEi6+jQg4AI906CV4pwWsio+d541icjDdkNlaFV17EZlbAKrpM/M7cW0rYMaWdHahg0jkjgQyGhdw4+4f6d8Yk4+FewCbEXt2ItVyziqgGXbl8nyLjdaQpx+CyRgmtK5Suowhqy8WUfbBATuqCRM=
Message-ID: <a4e6962a050419045752cc8be0@mail.gmail.com>
Date: Tue, 19 Apr 2005 06:57:17 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: 7eggert@gmx.de
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <E1DNJZD-0006vK-11@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3Ki1W-2pt-1@gated-at.bofh.it> <3S8oN-So-17@gated-at.bofh.it>
	 <3S8oN-So-19@gated-at.bofh.it> <3S8oN-So-21@gated-at.bofh.it>
	 <3S8oN-So-23@gated-at.bofh.it> <3S8oN-So-25@gated-at.bofh.it>
	 <3S8oN-So-27@gated-at.bofh.it> <3S8oM-So-7@gated-at.bofh.it>
	 <3UmnD-6Fy-7@gated-at.bofh.it>
	 <E1DNJZD-0006vK-11@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/05, Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
<7eggert@gmx.de> wrote:
> 
> > I was thinking about this a while back and thought having a user-mount
> > permissions file might be the right way to address lots of these
> > issues.  Essentially it would contain information about what
> > users/groups were allowed to mount what sources to what destinations
> > and with what mandatory options.
> 
> Users being able to mount random fs containing suid or device nodes
> are root whenever they want to. If you want to mount with dev or suid,
> use sudo and restrict the mount to a limited set of images/devices/whatever.
>

Well, that would kinda be the intent behind the permissions file  --
it can specify what restricted set of images/devices/whatever the user
can mount, I suppose the sensible thing would be to always enforce
nosuid and nsgid, but I'd rather keep these as the default version of
options (allowing admins to shoot themselves in the foot perhaps, but
in the single-user workstation case, is seems like there's less reason
to be so paranoid).

       -eric
