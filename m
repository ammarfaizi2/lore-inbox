Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWAXXI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWAXXI4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 18:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWAXXI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 18:08:56 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:50418 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750820AbWAXXIz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 18:08:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Uq3B/B3nkk8AJ4YG7XJW4t+y4kSx1fF89mHZYUAKk051MmHYrUac74Bng14+XQn/xmfd7WnpRhwzf8YMpByMetfeu0jEAV5Odyu3t77bV3lHTP44RS/WVu+cH3TzOpUP9jgaIJPhL1yQ1fapjv0fU4HPh6qTehJkTCdeBdYWL9s=
Message-ID: <d120d5000601241508l1a93aae7ubdf8206209be405c@mail.gmail.com>
Date: Tue, 24 Jan 2006 18:08:54 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Export symbols so CONFIG_INPUT works as a module
Cc: Dave Jones <davej@redhat.com>, Martin Michlmayr <tbm@cyrius.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060124184114.GS27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060124181945.GA21955@deprecation.cyrius.com>
	 <20060124183432.GA27917@redhat.com>
	 <20060124184114.GS27946@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/06, Al Viro <viro@ftp.linux.org.uk> wrote:
> On Tue, Jan 24, 2006 at 01:34:32PM -0500, Dave Jones wrote:
> > On Tue, Jan 24, 2006 at 06:19:45PM +0000, Martin Michlmayr wrote:
> >  > Currently, modular input support fails to load with the following error:
> >  >
> >  > qube:# modprobe input
> >  > input: Unknown symbol kobject_get_path
> >  > input: Unknown symbol add_input_randomness
> >  >
> >  > In the short run, this can be solved by exporting these two symbols.
> >  > There have been discussions about fixing this in a different manner,
> >  > see http://www.ussg.iu.edu/hypermail/linux/kernel/0505.2/1068.html
> >  > Since this was in the days of 2.6.12-rc4 and modular input support is
> >  > still broken, I suggest these symbols to be exported for now.
> >
> > Is there actually any practical reason why you would want to
> > make the input layer modular ?
>
> More interesting question: is pis^H^H^Hsysfs interaction in there safe for
> modular code?

The core should be safe, at least I was trying to make it this way, so
if you see something wrong - shout. Locking is another question
though...

--
Dmitry
