Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269867AbUJMVXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269867AbUJMVXf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 17:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269856AbUJMVWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 17:22:10 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:6793 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S269853AbUJMVVe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 17:21:34 -0400
Subject: Re: Fw: signed kernel modules?
From: "Rusty Russell (IBM)" <rusty@au1.ibm.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: dhowells <dhowells@redhat.com>, rusty@ozlabs.au.ibm.com,
       Greg KH <greg@kroah.com>, Arjan van de Ven <arjanv@redhat.com>,
       Joy Latten <latten@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1097658993.5178.57.camel@localhost.localdomain>
References: <1096544201.8043.816.camel@localhost.localdomain>
	 <1096411448.3230.22.camel@localhost.localdomain>
	 <1092403984.29463.11.camel@bach> <1092369784.25194.225.camel@bach>
	 <20040812092029.GA30255@devserv.devel.redhat.com>
	 <20040811211719.GD21894@kroah.com>
	 <OF4B7132F5.8BE9D947-ON87256EEB.007192D0-86256EEB.00740B23@us.ibm.com>
	 <1092097278.20335.51.camel@bach> <20040810002741.GA7764@kroah.com>
	 <1092189167.22236.67.camel@bach> <19388.1092301990@redhat.com>
	 <30797.1092308768@redhat.com>
	 <20040812111853.GB25950@devserv.devel.redhat.com>
	 <20040812200917.GD2952@kroah.com> <26280.1092388799@redhat.com>
	 <27175.1095936746@redhat.com> <30591.1096451074@redhat.com>
	 <10345.1097507482@redhat.com>
	 <1097507755.318.332.camel@hades.cambridge.redhat.com>
	 <1097534090.16153.7.camel@localhost.localdomain>
	 <1097570159.5788.1089.camel@baythorne.infradead.org>
	 <1097626296.4013.34.camel@localhost.localdomain>
	 <1097658993.5178.57.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Message-Id: <1097702476.14303.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 14 Oct 2004 07:21:16 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-13 at 19:16, David Woodhouse wrote:
> On Wed, 2004-10-13 at 10:11 +1000, Rusty Russell (IBM) wrote:
> > Here's the level of paranoia required for the simplest case, that of
> > signing the entire module.  The last Howells patches I saw didn't even
> > do any of *this*, let alone checking the rest of the module:
> 
> We agree that the checks you cite are required. In fact we should have
> been doing a lot of these checks even _before_ we thought about signing
> modules.

No.  What a complete and utter waste of time and code!  At the moment,
we do minimum checks; this is because we don't even try to keep out
malicious code.  At the moment, flip and random bit in a module and
you'll get weird behaviour.  We don't check for that because we can't:
it's most likely in data or text anyway.

Now. if you're adding a signature, I insist that it should do detect all
relevant changes.  Calling David's a "work in progress" and that "I'm
sure these problems will be fixed" doesn't ignore the fact that he has
resisted fixing them so far.  He just doesn't seem to understand: could
you explain it to him please? 

You are arguing that he should add elaborate checks, with care for those
arch-specific hooks and the requisite paranoia.  I'm arguing that he
should just sum the whole module and be done.  My method is far simpler,
with the cost that stripping the module requires a signature update.

If you really insist that the complexity is worth it, I want to see the
code.  ALL the code.  Because at the moment you're cheating.

Rusty.


