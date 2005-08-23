Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbVHWNuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbVHWNuf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 09:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVHWNuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 09:50:35 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:12040 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932175AbVHWNue convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 09:50:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GovbdmtsP/bVNo3L1gYDHk3KkERriguxw2DZrMrbbbZSM/+qqaho4Mjd6i4GoZZRVeoMNTphGQ7uknHhX7DwThn3sH4WOgVAJ0jM+09+dT4hHoF+YcoEIhTriqlUigpeaT0PMSo6p6fo1vzsoeHO7fq5gOSafkK8M8omV7Az710=
Message-ID: <d120d50005082306506fc9bd51@mail.gmail.com>
Date: Tue, 23 Aug 2005 08:50:32 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Christoph Hellwig <hch@infradead.org>,
       Pekka J Enberg <penberg@cs.helsinki.fi>, Andrew Morton <akpm@osdl.org>,
       Pekka Enberg <penberg@gmail.com>, nathans@sgi.com,
       dtor_core@ameritech.net, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH] mm: return ENOBUFS instead of ENOMEM in generic_file_buffered_write
In-Reply-To: <20050823115559.GA6348@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <11394.1124781401@kao2.melbourne.sgi.com>
	 <200508190055.25747.dtor_core@ameritech.net>
	 <20050823073258.GE743@frodo>
	 <84144f02050823005573569fcb@mail.gmail.com>
	 <20050823012839.649645c2.akpm@osdl.org>
	 <Pine.LNX.4.58.0508231145060.30649@sbz-30.cs.Helsinki.FI>
	 <20050823115559.GA6348@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/05, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Aug 23, 2005 at 11:46:33AM +0300, Pekka J Enberg wrote:
> > As noticed by Dmitry Torokhov, write() can not return ENOMEM:
> >
> > http://www.opengroup.org/onlinepubs/000095399/functions/write.html
> >
> > Therefore fixup generic_file_buffered_write() in mm/filemap.c (pointed out by
> > Nathan Scott).
> 
> We had this discussion before, for EACCESS then.  We've always been returning
> more errnos than SuS mentioned and Linus declared it's fine.
> 

So does that mean that any error code is allowed? I would love to be
able to return ENODEV from a sysfs attribute if its device happens to
be removed in process. Is there a list of valid errnos for Linux that
supercedes SuS?

-- 
Dmitry
