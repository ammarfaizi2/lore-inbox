Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWBZTBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWBZTBY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 14:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWBZTBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 14:01:24 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:53607 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932143AbWBZTBX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 14:01:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TPqXRedjgvVJMEdgyQAM6pKPex4CpKbsdsD/v8F7ccGHWKzi9xpZGNAa5PBwKZEnaNNJenh6I9k5YvyKM++oKKCG7wOqFg4d81WLxj3msSUeihP4yAqaeoYiDCNdc/w0BW8pI91/1ZWNCaGrBRikFH4PW7N7O5r7kvVJ3qCxFCs=
Message-ID: <9a8748490602261101q39f4cf8eqabe0143921389ce6@mail.gmail.com>
Date: Sun, 26 Feb 2006 20:01:22 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "James Bottomley" <James.Bottomley@steeleye.com>
Subject: Re: [PATCH] silence gcc warning about possibly uninitialized use of variable in scsi_scan
Cc: linux-kernel@vger.kernel.org, "Eric Youngdale" <ericy@cais.com>,
       "Eric Youngdale" <eric@andante.org>, linux-scsi@vger.kernel.org
In-Reply-To: <1140980377.3692.9.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602261639.15657.jesper.juhl@gmail.com>
	 <1140978084.3692.6.camel@mulgrave.il.steeleye.com>
	 <9a8748490602261023j46eb39f2peaa080d737fee5e1@mail.gmail.com>
	 <1140980377.3692.9.camel@mulgrave.il.steeleye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/06, James Bottomley <James.Bottomley@steeleye.com> wrote:
> On Sun, 2006-02-26 at 19:23 +0100, Jesper Juhl wrote:
> > > gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)
> > >
> > > Doesn't give this warning.  And, since the loop has fixed parameters,
> > > gcc should see not only that it's always executed, but that it could be
> > > unrolled.
> > >
> > > Which version is causing the problem?
> > >
> > 2.6.16-rc4-mm2 build with gcc 3.4.5
>
> I also tried with
>
> gcc version 3.3.5 (Debian 1:3.3.5-13)
>
> which likewise fails to give this warning, so I really think this is a
> bug in your particular version of gcc.
>

Hmm, it's quite reproducible and the gcc 3.4.5 I have here is not
patched by the distribution (Slackware). If you want I can send you
the .config that results in the warning..

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
