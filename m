Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWDTXyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWDTXyN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 19:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWDTXyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 19:54:12 -0400
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:40410 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932152AbWDTXyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 19:54:10 -0400
Date: Thu, 20 Apr 2006 19:54:07 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Al Viro <viro@ftp.linux.org.uk>
cc: Linda Walsh <lkml@tlinx.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 11/11] security: AppArmor - Export namespace semaphore
In-Reply-To: <20060420215646.GB27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0604201942550.18177@d.namei>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
 <20060419175034.29149.94306.sendpatchset@ermintrude.int.wirex.com>
 <1145536742.16456.35.camel@moss-spartans.epoch.ncsc.mil> <44480228.3060009@tlinx.org>
 <20060420215646.GB27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2006, Al Viro wrote:

> On Thu, Apr 20, 2006 at 02:50:32PM -0700, Linda Walsh wrote:
> > any access control scheme to be implemented?  I've seen complaints
> > before on either here or the LSM list that one of the hurdles for
> > "legitimacy" was whether or not it fit on top of the current set of
> > LSM hooks.  I also saw it asked whether or not LSM had been
> > designed
> 
> ... and the answer is obviously "no".  AFAICS, that was a way to get
> around Linus' "at least decide on a common set of core kernel modifications"
> without any kind of thinking being involved.

For reference, here are the original comments from Linus which were used 
to conceive LSM:
http://marc.theaimsgroup.com/?l=linux-security-module&m=98706471912438&w=2

In a nutshell, Linus did not want to have to choose a security model.

In my view, the generic, correctly abstracted mechanism was actually 
SELinux all along, and unfortunately, only a few people really understood 
that then.  SELinux was itself designed to allow different security models 
to be composed, with clean separation of models, policy and enforcement 
mechanism.

LSM was somewhat designed around SELinux, but necessarily lacking the 
stronger semantics of SELinux, to allow other similar schemes to be 
plugged in (the first significant example of which other than SELinux, has 
only just appeared on lkml five years later).


- James
-- 
James Morris
<jmorris@namei.org>
