Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbWHOKmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWHOKmK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 06:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbWHOKmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 06:42:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:46852 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030191AbWHOKmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 06:42:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GRipQT3X1TKFb8ADrwiHcZjCdJ5WTKGPTcxVN94Rn4daY1OdDfmkAT3RbTpii0AKfCT4RUwetDs+JLVRDFeZ4sYns2Jsj+1EqKLynVylZfVs2KM5HnjAwYVcJga3VIMlNdd7v6rxu7y9VA2wjc9Bv1vQWO7AycozNGE2nVM5J4o=
Message-ID: <9a8748490608150342i1e546484kb66ff57ab78ebb05@mail.gmail.com>
Date: Tue, 15 Aug 2006 12:42:07 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "David Miller" <davem@davemloft.net>
Subject: Re: [PATCH] ISDN: fix double free bug in isdn_net
Cc: linux-kernel@vger.kernel.org, kkeil@suse.de, kai.germaschewski@gmx.de,
       isdn4linux@listserv.isdn4linux.de
In-Reply-To: <20060815.021503.71555009.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608122248.22639.jesper.juhl@gmail.com>
	 <20060815.020004.76775981.davem@davemloft.net>
	 <9a8748490608150208v4e8b7dccl6dd501a6f2cda4fc@mail.gmail.com>
	 <20060815.021503.71555009.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/06, David Miller <davem@davemloft.net> wrote:
> From: "Jesper Juhl" <jesper.juhl@gmail.com>
> Date: Tue, 15 Aug 2006 11:08:35 +0200
>
> > Hmm, perhaps I made a mistake and missed a path. Maybe it would be
> > better to fix if by making isdn_writebuf_skb_stub() always set the skb
> > to NULL when it does free it. That would add a few more assignments
> > but should ensure the right result always.
> > What do you say?
>
> Do we know if the ->writebuf_skb() method ever frees the skb?  If it
> never does, then yes your suggestion would be one way to handle this.
>
I'll look at it tonight and if writebuf_skb() method never frees the
skb I'll send a patch.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
