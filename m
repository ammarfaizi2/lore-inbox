Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbVFMRXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVFMRXy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 13:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVFMRXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 13:23:53 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:41457 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261542AbVFMRXj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 13:23:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dxyob2ZHN0ZnCDnAmyzIMY2AFd6SZh2MJN+jRA13kSTkSpgYfBwnNMbp7b4MdKtpXkBEI55utFO7FNIjZSD6kkflDXAdGiZzhNe5KmX6uclURkyUdcmotzDw22BA++tqdT5p5dhGWhmfmQdNh1lKhXL2UN0gU4aQGPxiNawlWac=
Message-ID: <9a87484905061310237e031c1a@mail.gmail.com>
Date: Mon, 13 Jun 2005 19:23:36 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: udp.c
Cc: Rommer <rommer@active.by>, Bernd Petrovitsch <bernd@firmix.at>,
       linux-kernel@vger.kernel.org
In-Reply-To: <yw1xu0k2beeh.fsf@ford.inprovide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <42AD74A3.1050006@active.by>
	 <1118664180.898.13.camel@tara.firmix.at>
	 <yw1xy89ebg14.fsf@ford.inprovide.com>
	 <1118666058.898.23.camel@tara.firmix.at> <42AD81FC.9020404@active.by>
	 <yw1xu0k2beeh.fsf@ford.inprovide.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/05, Måns Rullgård <mru@inprovide.com> wrote:
> Rommer <rommer@active.by> writes:
> 
> > Bernd Petrovitsch wrote:
> >> On Mon, 2005-06-13 at 14:24 +0200, Måns Rullgård wrote:
> >>
> >>>Bernd Petrovitsch <bernd@firmix.at> writes:
> >>>
> >>>
> >>>>On Mon, 2005-06-13 at 14:57 +0300, Rommer wrote:
> >>>>
> >>>>>Where used strange function udp_v4_hash?
> >>>>>linux-2.6.11.11, net/ipv4/udp.c:204
> >>>>>
> >>>>>static void udp_v4_hash(struct sock *sk)
> >>>>
> >>>>Since it is "static" the user must be in the same source file (or -
> >>>>theoretically - any included header).
> >>>
> >>>It's not that simple.  It is assigned to the 'hash' field of a struct
> >> If you interpret "called" word-by-word yes. I assumed "used".
> >>
> >>>proto, which is exported.  It could be used from anywhere, but
> >> The the OP has to grep for dereferences for this hash variable and
> >> check
> >> if it is (or may be) from the given struct.
> >> Well, that's the virtue of object-orientation: Follow the objects, not
> >> the functions/methods.
> >>
> >>>hopefully isn't.  Something else is supposed to ensure that it is
> >>>never called when using the UDP protocol.
> >
> > So, why BUG(), not just void function?
> 
> Calling the function would be the result of a bug elsewhere in the
> code, which should be detected and reported.
> 
Why not remove the function and audit the code for users (and if any,
remove them)...? Let's get rid of it instead of having a function sit
around the only purpose of which is to BUG();

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
