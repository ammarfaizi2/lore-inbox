Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266436AbUGJVVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266436AbUGJVVA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 17:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266435AbUGJVVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 17:21:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43237 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266436AbUGJVU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 17:20:28 -0400
To: arjanv@redhat.com
Cc: Zan Lynx <zlynx@acm.org>, ncunningham@linuxmail.org,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Jakub Jelinek <jakub@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GCC 3.4 and broken inlining.
References: <1089287198.3988.18.camel@nigel-laptop.wpcb.org.au>
	<20040708120719.GS21264@devserv.devel.redhat.com>
	<1089288664.2687.23.camel@nigel-laptop.wpcb.org.au>
	<200407090036.39323.vda@port.imtp.ilyichevsk.odessa.ua>
	<1089324043.3098.3.camel@nigel-laptop.wpcb.org.au>
	<1089326491.22042.68.camel@localhost.localdomain>
	<1089356043.2805.2.camel@laptop.fenrus.com>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 10 Jul 2004 18:20:19 -0300
In-Reply-To: <1089356043.2805.2.camel@laptop.fenrus.com>
Message-ID: <orzn67o8z0.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul  9, 2004, Arjan van de Ven <arjanv@redhat.com> wrote:

>> 
>> I believe that just adding -funit-at-a-time as a compile option solves
>> the problems with inline function body ordering.

> ... except that -funit-at-a-time causes some functions to use more than
> 4Kb of *extra* stack, even without CONFIG_4KSTACKS that's a ticking
> timebomb of enormous magnitude..

But that's because of excessive inlining.  I suppose the abuse of
attribute always_inline may very well be the culprit.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
