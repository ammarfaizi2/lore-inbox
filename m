Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbWKMVNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWKMVNt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 16:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWKMVNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 16:13:49 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:33626 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932488AbWKMVNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 16:13:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=bsTNPKG+0OyyccaXGmFYEYp0FiSePMLj2g0vI/RPNzfVWDSYAGWGgR5u1g/eVUkL4ddXE5TA7Bg1ALajVCsHD75klOh29jNL+MtFksaFUK3Qr7eM8qZaxnfnFNWo/ChZkmrLp5Yh3t1JzmRHjVWdSEFnJmpxm2NO8G9IiJl4t9A=
Date: Tue, 14 Nov 2006 00:13:35 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Zack Weinberg <zackw@panix.com>, Chris Wright <chrisw@sous-sol.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, jmorris@namei.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2/4] permission mapping for sys_syslog operations
Message-ID: <20061113211335.GE4971@martell.zuzino.mipt.ru>
References: <20061113064043.264211000@panix.com> <20061113064058.779558000@panix.com> <1163409918.15249.111.camel@laptopd505.fenrus.org> <eb97335b0611130129r7cdb8c8cuc8f2360e1f17f8f3@mail.gmail.com> <1163411238.15249.114.camel@laptopd505.fenrus.org> <eb97335b0611130917j18191c0ej3220b10c090d686f@mail.gmail.com> <1163438525.15249.181.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163438525.15249.181.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2006 at 06:22:04PM +0100, Arjan van de Ven wrote:
> On Mon, 2006-11-13 at 09:17 -0800, Zack Weinberg wrote:
> > On 11/13/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > > On Mon, 2006-11-13 at 01:29 -0800, Zack Weinberg wrote:
> > > > I thought the point of the "unifdef" thing was that it made a version
> > > > of the header with the __KERNEL__ section ripped out, for copying into
> > > > /usr/include, so you didn't have to do that ...
> > >
> > > yes it is, however it's mostly for existing stuff/seamless transition.
> > > It's a hack :)
> > > If you can avoid it lets do so; you already have the nice clean header,
> > > so lets not go backwards... you HAVE the clean separation.
> >
> > ok, but I gotta ask that you tell me what to name the internal header,
> > I can't think of anything that isn't ugly.
>
> klog.h vs klogd.h ? or klog_api.h for the user one ?
>
> (and yes I suck at names even more than you do ;)

What about security.h, so SELinux folks won't feel lonely there?
:)

