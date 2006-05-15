Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWEOJx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWEOJx5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 05:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWEOJx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 05:53:56 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:22700 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964871AbWEOJxz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 05:53:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KoA6MTF3T9p+4ME3e596eQfH65scmJbBtditHh65Z6pEVHPfjKW5Uf8o2hsKEQnpRWNl/GmDJ8NkSQrJmfnlepcGjmeQIj0hjnuAWV8h4Ra/fkPTxAcyNaD2y4w8C3Nc5ylBqW9bwLe0SwgjBgv5PIqhy+8P0ePitgkoplOLxaw=
Message-ID: <9a8748490605150253w4448ea8q1a4f587ef66ea680@mail.gmail.com>
Date: Mon, 15 May 2006 11:53:55 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Alan Cox" <alan@redhat.com>
Subject: Re: [PATCH] fix dangerous pointer derefs and remove pointless casts in MOXA driver
Cc: linux-kernel@vger.kernel.org, "Moxa Technologies" <support@moxa.com.tw>,
       "Martin Mares" <mj@ucw.cz>
In-Reply-To: <20060515093457.GA9780@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605140349.36122.jesper.juhl@gmail.com>
	 <20060515093457.GA9780@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/06, Alan Cox <alan@redhat.com> wrote:
> On Sun, May 14, 2006 at 03:49:35AM +0200, Jesper Juhl wrote:
> > If mxser_write() gets called with a NULL 'tty' pointer, then the initial
> > assignment of tty->driver_data to info will explode.
>
> If mxser_write gets called with a NULL pointer then you've already got such
> serious problems it isn't worth checking
>
> > Please consider for inclusion.
>
> Just delete the checks.  Also the little cast cleanup looks good so submit
> that as a separate patch too.
>

Thank you for the feedback.
I'll do that in two sepperate patches later this evening.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
