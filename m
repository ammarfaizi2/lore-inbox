Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317707AbSGVR2b>; Mon, 22 Jul 2002 13:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317709AbSGVR2b>; Mon, 22 Jul 2002 13:28:31 -0400
Received: from pc-62-30-72-138-ed.blueyonder.co.uk ([62.30.72.138]:27014 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S317707AbSGVR2a>; Mon, 22 Jul 2002 13:28:30 -0400
Date: Mon, 22 Jul 2002 18:31:32 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Heinz Diehl <hd@cavy.de>, linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: [2.5.26] ext3 from Dec. 2001?
Message-ID: <20020722183132.E10634@redhat.com>
References: <20020720151600.GA268@chiara.cavy.de> <3D3B8FBE.D5C11685@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D3B8FBE.D5C11685@zip.com.au>; from akpm@zip.com.au on Sun, Jul 21, 2002 at 09:53:18PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jul 21, 2002 at 09:53:18PM -0700, Andrew Morton wrote:

> > Just a short question: is there a patch for 2.5.26 to update ext3 to
> > ext3-0.9.18? There's still ext3-0.9.16 from Dec. 2001 present in 2.5.26.
> > At ../people/sct on ftp.kernel.org there are only updates for kernel
> > 2.2 and 2.4.
> 
> 2.5 is uptodate wrt the current ext3-for-2.4 development tree.
> That means that it's more uptodate than 2.4 is...

Yes --- I've been holding back on the changes in the ext3 CVS because
of one nagging bug which I've been hunting for, and which I think I
just found two weeks ago, the day before I left for a holiday.  (It's
another possible cause for a "buffer_jdirty()" assert failure in
commit.c on SMP machines.)

I'll get that checked in shortly.

> Some recent changes to ext3 have exposed a data=journal bug
> in 2.5 which is also present in 2.4, but is much harder to hit
> there.  I'm not sure what Stephen's intentions are on a 2.4
> upgrade, but I'd be inclined to sit tight until 2.4.20-pre.

I'm just back from holiday so I haven't been able to do much on this
recently, but I've got a fix mostly coded --- it just doesn't
actually work particularly well, yet.  :-)

Cheers,
 Stephen
