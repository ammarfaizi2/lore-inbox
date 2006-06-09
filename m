Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030545AbWFIVvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030545AbWFIVvv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030544AbWFIVvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:51:51 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:37781 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030541AbWFIVvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:51:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lM4OpmRfl7gwcSSEyUXk/lcKJt0KdBr2BMR1FkBC6dpvYVQk9f0vqOrDZHoAOUVqWBzI6+W8GJ/MldOWB1wL5f8UYsqovZiL+zrKMR/6+9D/MXKnt8PZDOitrYCRt8pn6xYth5zfHSyC/EiNnd41az56bZ8wb87snnt4Jbi1HA4=
Message-ID: <170fa0d20606091451h91c1fe3m2fe8839699008c60@mail.gmail.com>
Date: Fri, 9 Jun 2006 17:51:48 -0400
From: "Mike Snitzer" <snitzer@gmail.com>
To: "Dave Jones" <davej@redhat.com>, "Theodore Tso" <tytso@mit.edu>,
       "Jeff Garzik" <jeff@garzik.org>, "Alex Tomas" <alex@clusterfs.com>,
       "Andrew Morton" <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       "Andreas Dilger" <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
In-Reply-To: <20060609210934.GH3574@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44898EE3.6080903@garzik.org>
	 <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>
	 <m33beecntr.fsf@bzzz.home.net>
	 <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>
	 <m3k67qb7hr.fsf@bzzz.home.net> <4489A7ED.8070007@garzik.org>
	 <20060609195750.GD10524@thunk.org>
	 <20060609203803.GF3574@ca-server1.us.oracle.com>
	 <20060609205036.GI7420@redhat.com>
	 <20060609210934.GH3574@ca-server1.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/06, Joel Becker <Joel.Becker@oracle.com> wrote:
> On Fri, Jun 09, 2006 at 04:50:36PM -0400, Dave Jones wrote:
> > On Fri, Jun 09, 2006 at 01:38:03PM -0700, Joel Becker wrote:
> >  > that the older code cannot read.  Alex claims people just shouldn't use
> >  > "-o extents", but the fact is their distro will choose it for them.
> >
> > .. on partitions over a certain size, which couldn't be read with
> > older ext3 filesystems _anyway_
>
>         Certainly that would be fine.  Is that what will actually
> happen?  Experience says no.  Even if you get it right in your distro,
> not all distros will.  Heck, can you promise me that your distro will
> provide e2fsprogs updates to its older releases so that multiboot will
> continue to work?

If the kernel were bound by all the stakeholders' ability to _always_
"do the right thing" very little innovation would be possible.  These
tenuous arguments of hypothetical (ab)users are tiresome.

If the distro vendor did default to ext3+extents and it screwed your
hypothetical extents-naive user (booting a non-vendor kernel isn't
something your mom is going to do) then they strayed too far from
their Linux comfort-zone. If worst came to worst _THE UPDATED
EXT3UTILS WOULD PREVENT MOUNTING AN EXT3 FS WITH AN INCOMPATIBLE
FEATURE_.  God forbid the naive-user get an error when they try
something they shouldn't.
