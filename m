Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751774AbWFVMbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbWFVMbc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 08:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbWFVMbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 08:31:32 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:46552 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751774AbWFVMbb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 08:31:31 -0400
Date: Thu, 22 Jun 2006 07:31:02 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
       David Quigley <dpquigl@tycho.nsa.gov>,
       Chris Wright <chrisw@sous-sol.org>,
       Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH 2/3] SELinux: add security_task_movememory calls to mm code
Message-ID: <20060622123102.GF27074@sergelap.austin.ibm.com>
References: <Pine.LNX.4.64.0606211517170.11782@d.namei> <Pine.LNX.4.64.0606211730540.12872@d.namei> <Pine.LNX.4.64.0606211734480.12872@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606211734480.12872@d.namei>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting James Morris (jmorris@namei.org):
> From: David Quigley <dpquigl@tycho.nsa.gov>
> 
> This patch inserts security_task_movememory hook calls into memory
> management code to enable security modules to mediate this operation
> between tasks.
> 
> Since the last posting, the hook has been renamed following feedback from
> Christoph Lameter.
> 
> This patch is aimed at 2.6.18 inclusion.
> 
> Please apply.

Hi,

sorry if I'm being dense - what is actually being protected against
here?  The only thing I can think of is one process causing performance
degradation to another by moving it's memory further from it's cpu on a
NUMA machine.

Is there something more?  (And is what I'm guessing even possible?)

I'm not arguing against this hook, just wondering whether there's
more to this than I see.

thanks,
-serge
