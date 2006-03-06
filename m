Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWCFPzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWCFPzF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 10:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWCFPzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 10:55:05 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:57437 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750824AbWCFPzD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 10:55:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y0bitoEfXlIKANhiqPecKlKgFttmVsv4l+oaokIhgGi3xT+yI+E8z/oyNI2rOmHPDm5DTxg45vKb2cTLhfF9gPv1q/+fYwNJ7msKmIZEK9zpCVRiYE3Kq7bxk10oYpzeViZijwBpnN313m3wiF4hqcgDyYCuoDOD0SZ383AcLrY=
Message-ID: <9a8748490603060755r55b3584bpf0a16451a57925b5@mail.gmail.com>
Date: Mon, 6 Mar 2006 16:55:02 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Olivier Galibert" <galibert@pobox.com>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Re: Is that an acceptable interface change?
In-Reply-To: <20060306155021.GA23513@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060306011757.GA21649@dspnet.fr.eu.org>
	 <1141631568.4084.2.camel@laptopd505.fenrus.org>
	 <20060306155021.GA23513@dspnet.fr.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/06, Olivier Galibert <galibert@pobox.com> wrote:
> On Mon, Mar 06, 2006 at 08:52:48AM +0100, Arjan van de Ven wrote:
> > On Mon, 2006-03-06 at 02:17 +0100, Olivier Galibert wrote:
> > > I'm looking at the changes in the asound.h file, and especially at
> > > commit 512bbd6a85230f16389f0dd51925472e72fc8a91, and I've been
> > > wondering if it's acceptable compatibility-wise.  All the structures
> > > passed through ioctl (and ALSA is 100% ioctl) have been renamed from
> > > sndrv_* to snd_*.  That breaks source compatibility but not binary
> > > compatibility.
> >
> > only if you are "stupid" enough to use kernel headers in your userspace!
> > Which you shouldn't do normally
>
> Does that mean it is the responsability of whoever packages the
> headers for userspace consumption to rename the structs back?  Or that
> every application should come with its own copy of the kernel headers
> it may need and be ready for massive source-level breakage when
> rebasing?
>
> I'm just trying to understand if we care about source compatibility
> for userspace or not.
>

Userspace apps should not include kernel headers, period.
So, userspace applications really shouldn't care.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
