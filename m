Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277592AbRJHXGh>; Mon, 8 Oct 2001 19:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277594AbRJHXG2>; Mon, 8 Oct 2001 19:06:28 -0400
Received: from t2.redhat.com ([199.183.24.243]:3825 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S277592AbRJHXGN>; Mon, 8 Oct 2001 19:06:13 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011008.154650.48796051.davem@redhat.com> 
In-Reply-To: <20011008.154650.48796051.davem@redhat.com>  <1573466920.1002300846@mbligh.des.sequent.com> <15294.24873.866942.423260@cargo.ozlabs.ibm.com> <13962.1002580586@redhat.com> 
To: "David S. Miller" <davem@redhat.com>
Cc: frival@zk3.dec.com, paulus@samba.org, Martin.Bligh@us.ibm.com,
        alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, jay.estabrook@compaq.com,
        rth@twiddle.net
Subject: Re: [PATCH] change name of rep_nop 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Oct 2001 00:06:28 +0100
Message-ID: <14658.1002582388@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davem@redhat.com said:
>  Yes, I know the text isn't there, but that is the implication. Add
> the text, don't add a stupid "simon_says.." interface.

> The mtrr stuff, if it really does need the flush, should probably make
> it's own macro/inline with a huge comment about it explaining why the
> flush is actually needed.

It's not just mtrr stuff, and it's not just arch-specific code either. In
some cases, there is a need for a function which actually does flush the
cache.

Feel free to suggest an alternative name for it, as long as it's not
'wbinvd' - I would have picked flush_cache_all(), but that is already taken
by a function which generally doesn't actually flush the cache :)

--
dwmw2


