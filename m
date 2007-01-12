Return-Path: <linux-kernel-owner+w=401wt.eu-S1161002AbXALKyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbXALKyh (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 05:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161037AbXALKyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 05:54:37 -0500
Received: from wr-out-0506.google.com ([64.233.184.234]:39256 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161002AbXALKyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 05:54:37 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V/iHFzHQoZJ2hGql5ZvMxZr4dPuc34q85ApDPA0DHx41vsXFxQvidcgvDxKRlKLFegGfs1E+0j45fAtvo+FMRiyXBLY42GrG06KgTNPk4LAaZ+jGCkJL07hrkQyl+0uJqSTURUQoxOQp6fLtzWjQF8mlQLknu+cqyjv3n1+rh24=
Message-ID: <9a8748490701120254x6a7dd93aw9dd75994af661f5e@mail.gmail.com>
Date: Fri, 12 Jan 2007 11:54:33 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: How can I create or read/write a file in linux device driver?
Cc: congwen <congwen@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0701121139010.17236@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200701121547221465420@gmail.com>
	 <9a8748490701120227h757d473ctaf5673aa318fe090@mail.gmail.com>
	 <Pine.LNX.4.61.0701121139010.17236@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/07, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>
> On Jan 12 2007 11:27, Jesper Juhl wrote:
> > On 12/01/07, congwen <congwen@gmail.com> wrote:
> >> Hello everyone, I want to create and read/write a file in Linux kernel or
> >> device driver,
> >
> > Don't read/write user space files from kernel space.
> >
> > Please search the archives, this get asked a lot and it has been
> > explained a million times why it's a bad idea.
> > You can also read http://www.linuxjournal.com/article/8110
>
> The article does it the bad way. IMHO filp_open() and
> vfs_read/vfs_write() are much less problematic wrt. to userspace.
> FWIW see
> ftp://ftp-1.gwdg.de/pub/linux/misc/suser-jengelh/kernel/quad_dsp-1.5.1.tar.bz2
>

There is no good way.  You simply should NOT do it.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
