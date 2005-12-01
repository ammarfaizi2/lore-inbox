Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbVLAVFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbVLAVFx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 16:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbVLAVFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 16:05:53 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:33781 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932472AbVLAVFw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 16:05:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NoWy+klm5FBRivH6GcbgiyYsMAcj8DaHaoidNSsGtfQkjUQ6CuGTSxb98EaS4BV+D6yQ6V47ChYTwJC3jathBlLJg/+mmLFgjuRA/TVx5mv5UEVUrNXt1xfAZckPDcdNv3P3525tDIG/9VT36dEvuzHH2BFasqtgb4BnIGtlAoQ=
Message-ID: <9611fa230512011242p526b5128ub2918a3fa48da10c@mail.gmail.com>
Date: Thu, 1 Dec 2005 20:42:59 +0000
From: Tarkan Erimer <tarkane@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG]: Software compiling occasionlly hangs under 2.6.15-rc1/rc2 and 2.6.15-rc1-mm2
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org,
       Anton Altaparmakov <aia21@cantab.net>
In-Reply-To: <20051129151044.7ce3ef4a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9611fa230511250312i55d0b872x82b8c33b4d2973e4@mail.gmail.com>
	 <1132917564.7068.41.camel@laptopd505.fenrus.org>
	 <9611fa230511270317led5b915h7daae3ef1287f86d@mail.gmail.com>
	 <1133092701.2853.0.camel@laptopd505.fenrus.org>
	 <9611fa230511271108m46389ee6w7ec6b5b40b1e23dd@mail.gmail.com>
	 <20051127165733.643d5444.akpm@osdl.org>
	 <9611fa230511291357g3aa964adj6918fea50f5ee66e@mail.gmail.com>
	 <20051129151044.7ce3ef4a.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/05, Andrew Morton <akpm@osdl.org> wrote:
> Tarkan Erimer <tarkane@gmail.com> wrote:
> >
> > On 11/28/05, Andrew Morton <akpm@osdl.org> wrote:
> > > XFS went nuts.  Please test the latest git snapshot which has fixes for
> > > this.
> >
> > I tried 2.6.15-rc2-git6 and just released 2.6.15-rc3. Result is same.
> > I still got occasional hangs.
>
> Please generate the sysrq-T trace when the system hangs.

I tried sysrq-T trace. But, When hit the bug, system completely freezes.
Alt+sysrq+t (Normally Alt+sysrq+t works perfectly) or any other
combination does not respond. Is there any other way to trace  this?
Also, I will try just-released 2.6.15-rc4 and let know the result.

> > When I check my syslog, I found no error
> > messages. But notice, XFS related errors have gone.
>
> OK, we might have fixed XFS.

Yes, thanks

> > Nov 29 23:23:57 hightemple gconfd (root-11625): starting (version
> > 2.12.1), pid 11625 user 'root'
> > Nov 29 23:23:57 hightemple gconfd (root-11625): Resolved address
> > "xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only
> > configuration source at position 0
> > Nov 29 23:23:57 hightemple gconfd (root-11625): Resolved address
> > "xml:readwrite:/root/.gconf" to a writable configuration source at
> > position 1
> > Nov 29 23:23:57 hightemple gconfd (root-11625): Resolved address
> > "xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only
> > configuration source at position 2
>
> I assume the above isn't kernel-related?

Yes, above is not related to the kernel. It is a Gnome thing.
