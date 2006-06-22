Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751808AbWFVO4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbWFVO4R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 10:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbWFVO4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 10:56:17 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:36747 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751804AbWFVO4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 10:56:17 -0400
Date: Thu, 22 Jun 2006 07:55:58 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
cc: James Morris <jmorris@namei.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
       Eric Paris <eparis@redhat.com>, David Quigley <dpquigl@tycho.nsa.gov>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 2/3] SELinux: add security_task_movememory calls to mm
 code
In-Reply-To: <20060622123102.GF27074@sergelap.austin.ibm.com>
Message-ID: <Pine.LNX.4.64.0606220755180.27962@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0606211517170.11782@d.namei>
 <Pine.LNX.4.64.0606211730540.12872@d.namei> <Pine.LNX.4.64.0606211734480.12872@d.namei>
 <20060622123102.GF27074@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006, Serge E. Hallyn wrote:

> sorry if I'm being dense - what is actually being protected against
> here?  The only thing I can think of is one process causing performance
> degradation to another by moving it's memory further from it's cpu on a
> NUMA machine.

Right.
 
> Is there something more?  (And is what I'm guessing even possible?)

In the case of move_pages() a process can find out where the pages of 
another process were allocated.
 
> I'm not arguing against this hook, just wondering whether there's
> more to this than I see.

I was wondering myself.

