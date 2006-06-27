Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWF0IlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWF0IlJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 04:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbWF0IlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 04:41:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:35875 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932314AbWF0IlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 04:41:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=IKKGuvE+nHRUMvHmyL6+iexMNJuvYdnKD1HaWtSYBl0q1S3x2LDmUazXEVbUEEQnU1UrbdALI9PznAqObuq2/hQwLW0yMWtn0HCU4VqePaBppMg8SLo/8bhr6rc5sNRzBVbaxuMxXaLyJEKjTa+vB87Txq4UFp7gnm803rl5xko=
Message-ID: <84144f020606270141x5a0afd6anfa6008bfcbba5fb@mail.gmail.com>
Date: Tue, 27 Jun 2006 11:41:05 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: GFS2 and DLM
Cc: "Nathan Scott" <nathans@sgi.com>, "Christoph Hellwig" <hch@infradead.org>,
       "Steven Whitehouse" <swhiteho@redhat.com>,
       "Linus Torvalds" <torvalds@osdl.org>,
       "David Teigland" <teigland@redhat.com>,
       "Patrick Caulfield" <pcaulfie@redhat.com>,
       "Kevin Anderson" <kanderso@redhat.com>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060627082240.GA672@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1150805833.3856.1356.camel@quoit.chygwyn.com>
	 <20060623144928.GA32694@infradead.org>
	 <20060626200300.GA15424@elte.hu> <20060627063339.GA27938@elte.hu>
	 <20060627181632.A1297906@wobbly.melbourne.sgi.com>
	 <20060627082240.GA672@elte.hu>
X-Google-Sender-Auth: f8873325ad473c3b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/06, Ingo Molnar <mingo@elte.hu> wrote:
> and since XFS makes use of KM_SLEEP in 130+ callsites, that means it is
> in essence using GFP_NOFAIL massively!

Yup, it's not just a wrapper, XFS really has its own allocator and the
PF_FSTRANS magic makes it hard to convert to slab proper.

                                             Pekka
