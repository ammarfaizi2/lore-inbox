Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWF2Pns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWF2Pns (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 11:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWF2Pns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 11:43:48 -0400
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:31154 "EHLO
	mail6.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750797AbWF2Pnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 11:43:47 -0400
Date: Thu, 29 Jun 2006 11:43:45 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, David Quigley <dpquigl@tycho.nsa.gov>
Subject: Re: [PATCH 1/3] SELinux: Extend task_kill hook to handle signals
 sent by AIO completion
In-Reply-To: <1151595104.6999.67.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.64.0606291142220.24029@d.namei>
References: <Pine.LNX.4.64.0606281943240.17149@d.namei> 
 <20060629001628.GQ11588@sequoia.sous-sol.org> <1151595104.6999.67.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006, Stephen Smalley wrote:

> On Wed, 2006-06-28 at 17:16 -0700, Chris Wright wrote:
> > > +	void (*task_getsecid) (struct task_struct * p, u32 * secid);
> > 
> > Why not just:
> > 	u32 (*task_getsecid) (struct task_struct *p);
> 
> That's fine, although we should then change the SELinux exports as well
> to be consistent (and convert them all to secid rather than sid or
> ctxid, and eliminate duplication there that has crept in).  That can be
> done by later patch.

My preference is to leave it as-is, because these interfaces generally 
return only error values.  IMHO, it's always much clearer that way in any 
case, for APIs like this.



- James
-- 
James Morris
<jmorris@namei.org>
