Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbVIWXZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbVIWXZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 19:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbVIWXZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 19:25:56 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:56424 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751345AbVIWXZz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 19:25:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tTXvg8ORyKHB8Pc4d8JURlJc+hf4t6b53ejixpqYrDWP1MA4zWfqlBdVg7zdqZ1iRViBKhgQ9xuLf6lKXWD4XyreX+2iT2IPalFzcqbjGKbLfcm8dg8asidBRVgrzYiod+MXlTlAjWuyscTdkpQQZkzPCZUeJyVw/fhmt2o8Jqo=
Message-ID: <9a874849050923162522202ceb@mail.gmail.com>
Date: Sat, 24 Sep 2005 01:25:54 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [patch] x86_64: fix tss limit (was Re: CAN-2005-0204 and 2.4)
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Horms <horms@debian.org>,
       Nikos Ntarmos <ntarmos@ceid.upatras.gr>, 329354@bugs.debian.org,
       Frederik Schueler <fs@lowpingbastards.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       ak@suse.de
In-Reply-To: <20050923162245.C12631@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <E1EI1tH-0006Yy-00@master.debian.org>
	 <20050922023025.GA20981@verge.net.au> <20050922200446.GB9472@dmt.cnet>
	 <20050923151738.B12631@unix-os.sc.intel.com>
	 <9a87484905092315556e9fc0bd@mail.gmail.com>
	 <20050923162245.C12631@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/05, Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:
> On Sat, Sep 24, 2005 at 12:55:41AM +0200, Jesper Juhl wrote:
> > On 9/24/05, Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:
> > >         set_tssldt_descriptor(&cpu_gdt_table[cpu][GDT_ENTRY_TSS], (unsigned long)addr,
> > >                               DESC_TSS,
> > > -                             sizeof(struct tss_struct) - 1);
> > > +                             IO_BITMAP_OFFSET + IO_BITMAP_BYTES + 7);
> > >  }
> > >
> > [snip]
> >
> > Is it just me, or would it be nice with a symbolic name for this "7" ?
> > For someone reading the code for the first time it seems to me that
> > it's non-obvious why the 7 is there, and why it's 7 exactely - a
> > define would make it clearer as I see it.
>
> Andrew please apply this updated patch. Thanks.
>
[snip]

That change makes me happy :)

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
