Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161076AbWFKFKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161076AbWFKFKT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 01:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbWFKFKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 01:10:19 -0400
Received: from ns.suse.de ([195.135.220.2]:29383 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161076AbWFKFKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 01:10:17 -0400
From: Neil Brown <neilb@suse.de>
To: David Woodhouse <dwmw2@infradead.org>
Date: Sun, 11 Jun 2006 15:09:55 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17547.42403.669502.694618@cse.unsw.edu.au>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation  (FAQ matter)
In-Reply-To: message from David Woodhouse on Sunday June 11
References: <20060610222734.GZ27502@mea-ext.zmailer.org>
	<1149980791.18635.197.camel@shinybook.infradead.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday June 11, dwmw2@infradead.org wrote:
> On Sun, 2006-06-11 at 01:27 +0300, Matti Aarnio wrote:
> > Now that there is even an RFC published about SPF...
> 
> Please, don't do this. SPF makes assumptions about email which are just
> not true; it rejects perfectly valid mail.
> 
> http://david.woodhou.se/why-not-spf.html

Conversely, please do do this :-)

I agree with David that SPF breaks mail-as-we-know-it, but I cannot
help thinking that mail-as-we-know-it is way too permissive and bits
of it need to be broken (the old egg/omelette analogy).

And I think that kernel.org is a great place to start with pushing
SPF, because if a few mail items go astray to-or-from it really isn't
the end of the world.

- kernel.org should publish very strict SPF records that sites with
  any gumption can reject forged mail claiming to be from kernel.org.
  If systems drop mail incorrectly because of this, the end-recipient
  can follow linux-kernel any number of other ways, and can badger
  their local admins to "get it right".

- kernel.org should reject mail that earns an SPF 'fail' and should
  grey-list mail that earns an SPF 'softfail' (so the sending system
  will have to retry once). Any mail that incorrectly gets rejected
  will hopefully have a link to a web page that explains the problem
  and lists a number of free-mail sites where anyone can sign up and
  safely send mail to kernel.org.  So people who need to get mail
  through still can, while they complain to their admins about
  configuring things properly.

I think kernel.org is a great site to be an early adopter because:
  - the mail it transports isn't critical
  - it interacts with a very large number of mail sites
  - it's customers are reasonably technology-savvy. 

sourceforge would be another good site.


(No, SPF doesn't stop spam, but it can increase accountability so that
white/black lists can begin to be more usable).

NeilBrown
