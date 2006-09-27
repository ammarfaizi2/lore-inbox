Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030901AbWI0ViH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030901AbWI0ViH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 17:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030902AbWI0ViH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 17:38:07 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:59726 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030901AbWI0ViG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 17:38:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IXGokit2wn7WSW/sCDygoGhwo178oz/idbqo2UaBCUA39Gg3aq/b2Ero90ZQlCZDiHoWQqryTTGQ1kJMTroRdrKAAaRu5w2MI2TQuwjnF9Tontg5A/SKYFSugHsUWYl7Q0XqxqajgH0e1xGVmPhY0xop+PDHFxxTBDafIXmpRX0=
Message-ID: <9a8748490609271438n13d822e0x6af0bd06c32c8ae0@mail.gmail.com>
Date: Wed, 27 Sep 2006 23:38:05 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Randy Dunlap" <rdunlap@xenotime.net>
Subject: Re: Tiny error in printk output for clocksource : a3:<6>Time: acpi_pm clocksource has been installed.
Cc: gregkh <greg@kroah.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060926205415.98b8d95d.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490609261722g557eaeeayc148b5f5d910874d@mail.gmail.com>
	 <20060926173347.04fd66dd.rdunlap@xenotime.net>
	 <200609270236.58148.jesper.juhl@gmail.com>
	 <20060926205415.98b8d95d.rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/06, Randy Dunlap <rdunlap@xenotime.net> wrote:
> On Wed, 27 Sep 2006 02:36:58 +0200 Jesper Juhl wrote:
>
> > On Wednesday 27 September 2006 02:33, Randy Dunlap wrote:
> > > On Wed, 27 Sep 2006 02:22:18 +0200 Jesper Juhl wrote:
> > >
> > > > I get this in dmesg with 2.6.18-git6 :
> > > >       a3:<6>Time: acpi_pm clocksource has been installed.
> > > >
> > > > Looks like some printk() somewhere is not adding \n correctly after
> > > > outputting a message priority or a message priority too much is
> > > > used... I've not investigated where this happens, but just wanted to
> > > > report it.
> > >
> > > Hi,
> > > How about posting (pasting) some of the message log before that?
> > >
> > Sure, below is the entire dmesg output from this boot of the box
> > (including the line above) :
>
> I suppose that you have CONFIG_PCI_MULTITHREAD_PROBE=y ?

Correct.

> What happens if you change to to =n ?
>
Doing that resolves the issue.

So yes, you are correct in your other posts in this thread that the
problem is caused by multiple printk()'s from different locations
being mixed up.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
