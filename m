Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWI2Okq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWI2Okq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 10:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWI2Okp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 10:40:45 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:60777 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751123AbWI2Okn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 10:40:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=robkWdNi6sMMm/W6PPrK2IbXU12Lgtutwb22OwF7jyMH3hgxsVBmITq+ij9weEbZbXbzKA+0O/MyOf5755JzYTk2QxYxHvlKtHvRdK5dP6A+hArXeHVFBhyIZ7lz00zocjdVrqwD8ZlM39KOjwpo7e0maWT12tmVsxHhw8sPM6E=
Message-ID: <39e6f6c70609290740s79bf0b1cwe0b64eef8074eeeb@mail.gmail.com>
Date: Fri, 29 Sep 2006 11:40:43 -0300
From: "Arnaldo Carvalho de Melo" <arnaldo.melo@gmail.com>
To: "Gerrit Renker" <gerrit@erg.abdn.ac.uk>
Subject: Re: [PATCH] IPv6/DCCP: Remove unused IPV6_PKTOPTIONS code
Cc: "Andrew Morton" <akpm@osdl.org>, "Ian McDonald" <ian.mcdonald@jandi.co.nz>,
       "Jesper Juhl" <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, dccp@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>,
       "Pekka Savola" <pekkas@netcore.fi>, "James Morris" <jmorris@namei.org>,
       "Hideaki YOSHIFUJI" <yoshfuji@linux-ipv6.org>,
       "Patrick McHardy" <kaber@coreworks.de>,
       "Alexey Kuznetsov" <kuznet@ms2.inr.ac.ru>
In-Reply-To: <200609291102.19243@strip-the-willow>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200609290245.33618.jesper.juhl@gmail.com>
	 <20060928230751.99041004.akpm@osdl.org>
	 <200609291102.19243@strip-the-willow>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/06, Gerrit Renker <gerrit@erg.abdn.ac.uk> wrote:
> >  Coverity found what looks like a real leak in net/dccp/ipv6.c::dccp_v6_do_rcv()
>
> |  otoh, it seems to me that opt_skb doesn't actually do anything and can be
> |  removed?
> This is right, there is no code referencing opt_skb: compare with net/ipv6/tcp_ipv6.c.
> Until someone has time to add the missing DCCP-specific code, it does seem better
> to replace the dead part with a FIXME. This is done by the patch below, applies to
> davem-net2.6 and has been tested to compile.

Thanks, I've been again sidetracked by Real Life(tm) but hopefully
tomorrow I'll go over all the DCCP pending patches backlog and get
them into tree to submit to Dave.

- Arnaldo
