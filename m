Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313492AbSDPCYQ>; Mon, 15 Apr 2002 22:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313493AbSDPCYP>; Mon, 15 Apr 2002 22:24:15 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.247.199]:38407 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S313492AbSDPCYP>; Mon, 15 Apr 2002 22:24:15 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] + story;) on POSIX capabilities and SUID bit
Date: 16 Apr 2002 02:15:07 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <a9g1fb$onq$1@abraham.cs.berkeley.edu>
In-Reply-To: <Pine.LNX.4.33.0204122026170.903-100000@seldon.terminus.sk>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1018923307 25338 128.32.45.153 (16 Apr 2002 02:15:07 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 16 Apr 2002 02:15:07 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marek Zelem  wrote:
>Our new formula:
>  * (***) pP' = (fP & X) | (fI & pI)
>  *       pI' = pP'
>  *       pE' = ((pP' & pE) | fP) & X & fE

Can you say anything about why this is safe and doesn't introduce
vulnerabilities?  (The capabilities misfeature that caused sendmail
8.10.1 to leak root privilege really drove home for me the subtlety of
this stuff.)

Also, the meaning of fE and fP seem backwards from what I would have
expected.  Maybe this reflects a lack in my understanding in capabilities,
but I thought 'effective' refers to capabilities you're allowed to invoke
at the moment, whereas 'permitted' refers to an upper bound on what
capabilities you're allowed enable in 'effective', consequently I would
have swapped the treatment of fE and fP.  Can you clear up my confusion?

Finally, what's the story behind the changes to CAP_INIT_EFF_SET and
CAP_INIT_INH_SET, and the business with CAP_SETPCAP?  If I understand
correctly, one side-effect of this change is that you've changed cap_bset
(X, the global bound on capabilities above) to add CAP_SETPCAP to it.
Is this safe?  What motivated this change?  Did I understand correctly?
