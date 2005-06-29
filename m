Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262505AbVF2KiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262505AbVF2KiD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 06:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbVF2KiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 06:38:03 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:63362 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262505AbVF2Kh7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 06:37:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B2z6pqwcCnHk7x+hoUGyNCJdIn1WAFfSLjT0InS3QdodIcGI4b9h04Fffv+HwisiraMevkHtt11TEhszPKZ7xbuQ5L17fdctEGoYWvgyhCf/En0zi11b8T5+hf7Nh2CcyA0skloLZmznYlNTHukJnuPRHTgQQ6NazYcyfL26VrY=
Message-ID: <698310e10506290337681fad81@mail.gmail.com>
Date: Wed, 29 Jun 2005 14:37:56 +0400
From: Marat Buharov <marat.buharov@gmail.com>
Reply-To: Marat Buharov <marat.buharov@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Swap partition vs swap file
In-Reply-To: <20050628220334.66da4656.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <516d7fa80506281757188b2fda@mail.gmail.com>
	 <20050628220334.66da4656.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, but what about tells mkswap(8) tells:
"...Note that a swap file must not contain any holes (so, using  cp
(1) to create the file is not acceptable)..."?

If swap file will be fragmented it will contain holes.
Or what type of holes can cp(1) can create, which are not usefull for mkswap(8)?

2005/6/29, Andrew Morton <akpm@osdl.org>:
> Mike Richards <mrmikerich@gmail.com> wrote:
> >
> > Given this situation, is there any significant performance or
> >  stability advantage to using a swap partition instead of a swap file?
> 
> In 2.6 they have the same reliability and they will have the same
> performance unless the swapfile is badly fragmented.
>
