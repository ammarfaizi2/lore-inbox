Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318208AbSGPVIz>; Tue, 16 Jul 2002 17:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318212AbSGPVIy>; Tue, 16 Jul 2002 17:08:54 -0400
Received: from code.and.org ([63.113.167.33]:60115 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id <S318208AbSGPVIw>;
	Tue, 16 Jul 2002 17:08:52 -0400
To: Lawrence Greenfield <leg+@andrew.cmu.edu>,
       "Patrick J. LoPresti" <patl@curl.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
References: <20020712162306$aa7d@traf.lcs.mit.edu>
	<s5gsn2lt3ro.fsf@egghead.curl.com>
	<20020715173337$acad@traf.lcs.mit.edu>
	<s5gsn2kst2j.fsf@egghead.curl.com> <1026767676.4751.499.camel@tiny>
	<s5gy9ccr84k.fsf@egghead.curl.com>
	<200207160102.g6G12BiH022986@lin2.andrew.cmu.edu>
	<s5g8z4cphvd.fsf@egghead.curl.com>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 16 Jul 2002 17:09:05 -0400
In-Reply-To: <s5g8z4cphvd.fsf@egghead.curl.com>
Message-ID: <m3d6tnnzwu.fsf@code.and.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Patrick J. LoPresti" <patl@curl.com> writes:

> Lawrence Greenfield <leg+@andrew.cmu.edu> writes:
> 
> > Actually, it's not all that simple (you have to find the enclosing
> > directories of any files you're modifying, which might require string
> > manipulation)
> 
> No, you have to find the directories you are modifying.  And the
> application knows darn well which directories it is modifying.
> 
> Don't speculate.  Show some sample code, and let's see how hard it
> would be to use the "Linux way".  I am betting on "not hard at all".

 I added fsync() on directories to exim-3.31, it took about 2hrs
coding and another hours testing it (with strace) to make sure it was
doing the right thing. That was from almost never seeing the source
before.
 The only reason it took that long was because that version of exim
altered the spool in a couple of different places. Forward porting to
3.951 took about 20minutes IIRC (that version only plays witht he
spool in one place).

-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null
