Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWF2Pv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWF2Pv7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 11:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWF2Pv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 11:51:59 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:19959 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750820AbWF2Pv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 11:51:59 -0400
Subject: Re: [PATCH 1/3] SELinux: Extend task_kill hook to handle signals
	sent by AIO completion
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, David Quigley <dpquigl@tycho.nsa.gov>
In-Reply-To: <Pine.LNX.4.64.0606291142220.24029@d.namei>
References: <Pine.LNX.4.64.0606281943240.17149@d.namei>
	 <20060629001628.GQ11588@sequoia.sous-sol.org>
	 <1151595104.6999.67.camel@moss-spartans.epoch.ncsc.mil>
	 <Pine.LNX.4.64.0606291142220.24029@d.namei>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 29 Jun 2006 11:54:44 -0400
Message-Id: <1151596484.6999.85.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-29 at 11:43 -0400, James Morris wrote:
> On Thu, 29 Jun 2006, Stephen Smalley wrote:
> 
> > On Wed, 2006-06-28 at 17:16 -0700, Chris Wright wrote:
> > > > +	void (*task_getsecid) (struct task_struct * p, u32 * secid);
> > > 
> > > Why not just:
> > > 	u32 (*task_getsecid) (struct task_struct *p);
> > 
> > That's fine, although we should then change the SELinux exports as well
> > to be consistent (and convert them all to secid rather than sid or
> > ctxid, and eliminate duplication there that has crept in).  That can be
> > done by later patch.
> 
> My preference is to leave it as-is, because these interfaces generally 
> return only error values.  IMHO, it's always much clearer that way in any 
> case, for APIs like this.

Ok, fine with me.

-- 
Stephen Smalley
National Security Agency

