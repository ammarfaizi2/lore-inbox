Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316898AbSIEFwE>; Thu, 5 Sep 2002 01:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317012AbSIEFwE>; Thu, 5 Sep 2002 01:52:04 -0400
Received: from angband.namesys.com ([212.16.7.85]:20645 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S316898AbSIEFwD>; Thu, 5 Sep 2002 01:52:03 -0400
Date: Thu, 5 Sep 2002 09:56:38 +0400
From: Oleg Drokin <green@namesys.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: "David S. Miller" <davem@redhat.com>, mason@suse.com, reiser@namesys.com,
       shaggy@austin.ibm.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org, aurora-sparc-devel@linuxpower.org,
       reiserfs-dev@namesys.com, linuxjfs@us.ibm.com
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
Message-ID: <20020905095638.B5351@namesys.com>
References: <3D76A6FF.509@namesys.com> <1031186951.1684.205.camel@tiny> <20020905054008.GH24323@louise.pinerecords.com> <20020904.223651.79770866.davem@redhat.com> <20020905054858.GI24323@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020905054858.GI24323@louise.pinerecords.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Sep 05, 2002 at 07:48:58AM +0200, Tomas Szepe wrote:
> >    Does the internal reiserfs nlink value translate directly
> >    to what stat() puts in st_nlink?
> > It really doesn't matter.  Even if you have some huge value that can't
> > be represented in st_nlink, you can report to the user that st_nlink
> > is NLINK_MAX.
> > This is one possible solution to this whole problem.
> And a pretty straightforward one, too. Convert the internal reiserfs
> link stuff to an unsigned short, find NLINK_MAX using the code I posted

Too bad it is 32bit nlink field in on disk format ;)

> last night (or maybe simply grab it from userspace includes) and add
> a check to your stat() code to return NLINK_MAX if necessary.

Ok, I think I will rework it to something sensible, because current code is
somewhat a mess and corrupt correct nlink value on overflows. Hm.

Bye,
    Oleg
