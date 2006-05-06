Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWEFXzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWEFXzO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 19:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWEFXzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 19:55:14 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:29240 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750733AbWEFXzN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 19:55:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qrLOLU3nL9stoXigeSgHX3adxvLznvdWlNMmjY/LWyuhowXb5LBq5PE5LtuF2rPoXPx0FRM6zH7bxmmZSsUJ1Fzq3pjruLlxlAVrGWnsgvz8wEy1+grnWo0ylLhxaLyD5PB1dXN7l+ehT9bpsdYlpy7r40i+RP5NHK5N1xgd0jo=
Message-ID: <9a8748490605061655oaa7e114ua5dbf47206d92fd6@mail.gmail.com>
Date: Sun, 7 May 2006 01:55:12 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Dave Pitts" <dpitts@cozx.com>
Subject: Re: How can I boost block I/O performance
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <445CE6ED.30703@cozx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <445CE6ED.30703@cozx.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/06, Dave Pitts <dpitts@cozx.com> wrote:
> Hello all:
>
> I've been trying some hacks to boost disk I/O performance
[snip]
>
> This test is running several NFS clients to a RAID disk storage array. I
[snip]

For improving performance of NFS servers I've often had good success
with increasing the 'rsize' and 'wsize' options.
The default values are 4096, I personally set them to 16384 which
usually helps NFS performance quite a bit. At least that's my
experience.
Simply add  rsize=16384,wsize=16384  to the nfs mount options in
/etc/fstab and see if that improves performance for you (values like
8192 and 32768 may also be worth testing, but personally I've found -
at least with my setups - that 16384 seems to be the magic value).
('man 8 mount' and 'man 5 exports' also have more interresting options
you may want to experiment with, but just rsize & wsize on their own
should be a boost)

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
