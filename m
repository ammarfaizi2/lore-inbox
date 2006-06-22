Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751886AbWFVTWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbWFVTWv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbWFVTWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:22:51 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:30080 "EHLO
	sequoia.sous-sol.org") by vger.kernel.org with ESMTP
	id S1751886AbWFVTWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:22:50 -0400
Date: Thu, 22 Jun 2006 12:21:31 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: James Morris <jmorris@namei.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
       Eric Paris <eparis@redhat.com>, David Quigley <dpquigl@tycho.nsa.gov>,
       Chris Wright <chrisw@sous-sol.org>,
       Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH 2/3] SELinux: add security_task_movememory calls to mm code
Message-ID: <20060622192131.GW22737@sequoia.sous-sol.org>
References: <Pine.LNX.4.64.0606211517170.11782@d.namei> <Pine.LNX.4.64.0606211730540.12872@d.namei> <Pine.LNX.4.64.0606211734480.12872@d.namei> <20060622123102.GF27074@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622123102.GF27074@sergelap.austin.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Serge E. Hallyn (serue@us.ibm.com) wrote:
> sorry if I'm being dense - what is actually being protected against
> here?  The only thing I can think of is one process causing performance
> degradation to another by moving it's memory further from it's cpu on a
> NUMA machine.

There's been a short series of patches (plus a short doc from James) to
deal with code that's already doing uid/euid capable() checks w/out a
corresponding LSM hook.  IOW, it's already been recognized as security
sensitive and has DAC check w/out corresponding MAC check.  It's a small
issue with relatively minor security impacts, but is completing
mediation.

thanks,
-chris
