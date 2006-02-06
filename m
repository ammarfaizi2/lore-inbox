Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWBFRC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWBFRC0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 12:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWBFRC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 12:02:26 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:36006 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932224AbWBFRCZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 12:02:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nlqzW+25+S+KAux0IWP2lnyd0VDtLArT6O9lHpK5gawyBz7pFfiXb4zqbNvqwKZTeLwQ30WRxbmgGXTT/eXA369Wf1sdwn397J0tDT3ck/AUJ72egjXl8fdyCKNWQaIXkoUMshUqKA1x98QuCML6G93FeuLPQSYbQQMh6CbHyNk=
Message-ID: <5a2cf1f60602060902t40e9dd9fs9574cff2c746d552@mail.gmail.com>
Date: Mon, 6 Feb 2006 18:02:24 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.12.3 clock drifting twice too fast (amd64)
Cc: lkml <linux-kernel@vger.kernel.org>,
       Marie-Helene Lacoste <manies@tele2.fr>
In-Reply-To: <5a2cf1f605081616116ba521ab@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a2cf1f6050816031011590972@mail.gmail.com>
	 <1124228482.8630.95.camel@cog.beaverton.ibm.com>
	 <5a2cf1f605081616116ba521ab@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/05, jerome lacoste <jerome.lacoste@gmail.com> wrote:
> On 8/16/05, john stultz <johnstul@us.ibm.com> wrote:
> > On Tue, 2005-08-16 at 12:10 +0200, jerome lacoste wrote:
> > > Installed stock 2.6.12.3 on a brand new amd64 box with an Asus extreme
> > > AX 300 SE/t mainboard.
> > >
> > > I remember seeing a message in the boot saying something along:
> > >
> > >   "cannot connect to hardware clock."
> > >
> > > And now I see that the time is changing too fast (about 2 seconds each second).
> > [snip]
> > > 0000:00:00.0 Host bridge: ATI Technologies Inc: Unknown device 5951
> >
> > Looks like the AMD/ATI bug.
> >
> > http://bugzilla.kernel.org/show_bug.cgi?id=3927
>
> Sounds like it. I will have to try the patch.
>
> Good catch John!

Didn't have time to try the patch as my disk died. I installed a fresh
ubuntu with 2.6.12 (+ vendor patches) instead of 2.6.12.3, and the
issue disappeared.

So maybe ubuntu backported the aforementionned fix to their kernel.

Anyway, one less thing to worry.

jerome
