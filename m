Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUJ0OOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUJ0OOk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 10:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbUJ0OOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 10:14:40 -0400
Received: from serena.fsr.ku.dk ([130.225.215.194]:3014 "EHLO serena.fsr.ku.dk")
	by vger.kernel.org with ESMTP id S262450AbUJ0OOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 10:14:37 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: /proc/net/tcp not updated fast enough?
References: <2TTnT-7q3-31@gated-at.bofh.it> <2TV6i-i1-5@gated-at.bofh.it>
From: Henrik Christian Grove <grove@fsr.ku.dk>
Organization: Forenede =?iso-8859-1?q?Studenterr=E5d?= ved
  =?iso-8859-1?q?K=F8benhavns?= Universitet
Date: 27 Oct 2004 16:14:35 +0200
In-Reply-To: <2TV6i-i1-5@gated-at.bofh.it>
Message-ID: <7g7jpcp7sk.fsf@serena.fsr.ku.dk>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> writes:

> Henrik Christian Grove <grove@fsr.ku.dk> wrote:
>  
> > I have it running on 11[1] machines and since midnight (it's 11:47 here
> > now) I have 2397 succesfull connections, but in 31 cases (that's 1,29%
> > of the connections - and thus not totally ignorable) I had to read
> > through /proc/net/tcp twice to find the uid. Does that sound plausible,
> > or more like I'm doing something wrong?
> 
> /proc/net/tcp in 2.4 is inherently unreliable since it doesn't use
> the seqfile interface.  Your best bet is to use the tcp_diag interface
> instead.  You can either do that by using the ss command from the
> iproute2 suite, or you can query tcp_diag directly from C through
> netlink.

Thank you for the quick reply. Would you (or anyone else reading this)
happen to have any hints on what to do in Perl? (I know I can call ss,
but maybe there's a module with a nice interface?)

.Henrik

-- 
"Det er fundamentalt noget humanistisk vås, at der er noget, 
 der hedder blød matematik."
   --- citat Henrik Jeppesen, dekan for det naturvidenskabelige fakultet
