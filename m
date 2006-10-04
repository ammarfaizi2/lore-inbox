Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161092AbWJDGeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161092AbWJDGeG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 02:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161090AbWJDGeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 02:34:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:16720 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161092AbWJDGeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 02:34:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z6Mw/ERpFX5h8vvo6pH0hZAaPa+GRQZj+wC6R+3QCOYoJrpF2RFA1dT+0zicfkq0/p8Ykl1z6u/OFoZ0ajWeDQ2Np0fHFsZ4r2OOowDZU/cbV3m9yGTclhQuGI2sdvb4vyMA0MgbeV396251fdk16qnx+4JAx2ByC/ge72zqyT4=
Message-ID: <a36005b50610032334n50e66198rdfef30e4ccf545c8@mail.gmail.com>
Date: Tue, 3 Oct 2006 23:34:02 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>
Subject: Re: [take19 1/4] kevent: Core files.
Cc: lkml <linux-kernel@vger.kernel.org>, "David Miller" <davem@davemloft.net>,
       "Ulrich Drepper" <drepper@redhat.com>, "Andrew Morton" <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, "Zach Brown" <zach.brown@oracle.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Chase Venters" <chase.venters@clientec.com>,
       "Johann Borck" <johann.borck@densedata.com>
In-Reply-To: <1158744950130@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11587449471424@2ka.mipt.ru> <1158744950130@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> This patch includes core kevent files:
> [...]

I tried to look at the example programs before and failed.  I tried
again.  Where can I find up-to-date example code?

Some other points:

- I really would prefer not to rush all this into the upstream kernel.
 The main problem is that the ring buffer interface is a shared data
structure.  These are always tricky.  We need to find the right
combination between size (as small as possible) and supporting all the
interfaces.

- so far only the timer and aio notification is speced out.  What
about the rest?  Are we sure all aspects can be expressed?  I am not
yet.

- we need an interface to add an event from userlevel.  I.e., we need
to be able to synthesize events.  There are events (like, for instance
the async DNS functionality) which come from userlevel code.

I would very much prefer we look at the other events before setting
the data structures in stone.
