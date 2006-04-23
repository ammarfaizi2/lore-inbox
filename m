Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWDWMLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWDWMLT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 08:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWDWMLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 08:11:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:18396 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751386AbWDWMLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 08:11:18 -0400
Subject: Re: [RFC][PATCH 11/11] security: AppArmor - Export
	namespace	semaphore
From: Arjan van de Ven <arjan@infradead.org>
To: Linda Walsh <lkml@tlinx.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       linux-security-module@vger.kernel.org
In-Reply-To: <4448694E.90508@tlinx.org>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <20060419175034.29149.94306.sendpatchset@ermintrude.int.wirex.com>
	 <1145536742.16456.35.camel@moss-spartans.epoch.ncsc.mil>
	 <20060420124647.GD18604@sergelap.austin.ibm.com>
	 <1145534735.3313.3.camel@moss-spartans.epoch.ncsc.mil>
	 <20060420132128.GG18604@sergelap.austin.ibm.com>
	 <1145537318.3313.40.camel@moss-spartans.epoch.ncsc.mil>
	 <44480727.9010500@tlinx.org> <20060420230551.GA5026@infradead.org>
	 <4448355F.7070509@tlinx.org> <20060421020929.GG3828@sorel.sous-sol.org>
	 <4448694E.90508@tlinx.org>
Content-Type: text/plain
Date: Sun, 23 Apr 2006 14:11:13 +0200
Message-Id: <1145794274.3131.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 22:10 -0700, Linda Walsh wrote:
> Chris Wright wrote:
> > * Linda A. Walsh (law@tlinx.org) wrote:  
> >>    "The *current* accepted way to get pathnames going into system 
> >> calls is
> >> to put a trap in the syscall vector processing code to be indirectly
> >> called through the ptrace call with every system call as audit 
> >> currently does..."?
> >>
> >>    Or is that not correct either? 
> > No it's not.  See getname(9).
> 
>    I'm familiar with the getname call, it's probably the case that
> audit calls getname to do the actual copy from user->kernel space, I
> haven't checked.  But I can't find the manpage you are referring to.

you CANNOT copy twice. If you copy twice you might as well not audit
since userspace can just change it inbetween. what audit does is use the
original ONE copy that the normal syscall does .


