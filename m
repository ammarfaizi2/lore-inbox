Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWGCGIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWGCGIH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 02:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWGCGIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 02:08:07 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:15353 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750715AbWGCGID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 02:08:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=paiNnsWUMByMfytFqBTD0H6xu6AKrLEhLsvNOxV1eRpmx19udBhtMKzq6rCvZ1VysSYZafekKR7WCrz4E+jRCGDp8QXD3XqW2qjriEBSVl0pEcpHWReXGrNsLYiPAQd+cfyWiIRmGSDeAo76axcYLAVqn2AHUEiqrq+rrwa9xLU=
Message-ID: <a44ae5cd0607022308n646af3dh836df90b31e60dc@mail.gmail.com>
Date: Sun, 2 Jul 2006 23:08:03 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.17-mm4 + hostap + pcmcia + lockdep -- possible recursive locking detected -- (af_callback_keys + sk->sk_family#3){-.-?}, at: [<c119d8db>] sock_def_readable+0x15/0x69
Cc: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       "Arjan van de Ven" <arjan@infradead.org>
In-Reply-To: <20060702133451.GA27425@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0607011804i2326c350ta6262feec1e6805e@mail.gmail.com>
	 <20060702132946.GA25420@elte.hu> <20060702133451.GA27425@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Ingo Molnar <mingo@elte.hu> wrote:
>
> > * Miles Lane <miles.lane@gmail.com> wrote:
> >
> > > I have patches for hostap, pcmcia and lockdep applied to this kernel.
> > > These patches are the ones resulting from several recent message
> > > threads. I just noticed this in my kernel log:
> > >
> > > [ INFO: possible recursive locking detected ]
> > > ---------------------------------------------
> >
> > ok, lockdep should allow same-class read-lock recursion too, because
> > it's used by real code and is being relied upon. Could you try the patch
> > below? [...]
>
> the patches are also included in the latest -mm5 combo patch at:
>
>   http://redhat.com/~mingo/lockdep-patches/lockdep-combo-2.6.17-mm5.patch

I have not seen this particular INFO message show up again.
Therefore, I haven't tested your latest patch yet.  I wanted to determine
whether this problem would occur often.  If you like I can go ahead and
test the patch anyhow.  I am currently testing mm5 + the pcmcia patch and
the hostap patch.  I am looking into a crashing (system lockup) bug that is
triggered by removing my Linksys USB 10/100 Ethernet adapter.  This
problem is 100% repeatable.  I am working on setting up a remote
debugging configuration.

Would you like me to go ahead and test your latest patch?

Thanks,
            Miles
