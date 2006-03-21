Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbWCULKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbWCULKx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbWCULKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:10:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44719 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965035AbWCULKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:10:52 -0500
Subject: Re: [PATCH 2.6.16-rc6-xen] export Xen Hypervisor attributes
	to	sysfs
From: Arjan van de Ven <arjan@infradead.org>
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       gregkh@suse.de
In-Reply-To: <441FD8F3.208@us.ibm.com>
References: <200603202335.k2KNZEjo005673@mdday.raleigh.ibm.com>
	 <1142925269.3077.10.camel@laptopd505.fenrus.org>  <441FD8F3.208@us.ibm.com>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 12:10:44 +0100
Message-Id: <1142939444.3077.55.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 05:44 -0500, Mike D. Day wrote:
> Arjan van de Ven wrote:
> 
> >> +---properties
> >> |   >---capabilities
> >> |   >---changeset
> > 
> > how is this a property and not part of version?
> Agree, changeset should be part of version
> 
> > again what is the justification of putting this in the kernel? I though
> > everyone here was agreed that since the management tools that need this
> > talk to the hypervisor ANYWAY, they might as well just ask this
> > information as well....
> 
> I think we had a good discussion but short of agreement. Some tools want to 
> read a file from /sys/hypervisor/ rather than call a c lib. (In other words, 
> not all tools will talk to the hypervisor.) It is appropriate to view the 
> hypervisor as a hardware device so it is appropriate to have some information 
> in sysfs. 

then make a simple tool that gives the info to stdout


> I appreciate the counter argument as well, but think this should be a 
> configurable option. 

"a config option" is a cop-out. By proposing a config option you even
admit it's not essential for userspace. The last thing this should be is
a config option; it either is needed and important, and should be there
always, or it's redundant and should be done in userspace. "A config
option" is just admitting that it is the later, but that you need to
justify the time you spent on the kernel patch somewhere ;-)



