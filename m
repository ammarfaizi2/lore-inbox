Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVFCAt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVFCAt0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 20:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVFCAtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 20:49:25 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:31240 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261474AbVFCAtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 20:49:12 -0400
Date: Thu, 2 Jun 2005 17:54:22 -0700
To: john cooper <john.cooper@timesys.com>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       dwalker@mvista.com, Esben Nielsen <simlo@phys.au.dk>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       sdietrich@mvista.com, rostedt@goodmis.org
Subject: Re: [PATCH] Abstracted Priority Inheritance for RT
Message-ID: <20050603005422.GA6904@nietzsche.lynx.com>
References: <F989B1573A3A644BAB3920FBECA4D25A036671E5@orsmsx407> <429E9C9A.1030507@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429E9C9A.1030507@timesys.com>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 01:43:54AM -0400, john cooper wrote:
> That might have been me.  The last time I looked at this
> specifically, full transitive promotion was being done in
> the RT patch.  However unlike your attempt at scaling the
> lock scope, the RT patch had one lock which coordinated
> all mutex dependency traversals system wide.  This lock
> must be speculatively acquired even before we ascertain
> transitive promotion is required.
> 
> So it doesn't scale as well as it could in the case of
> large count SMP systems.  The response was that of "get
> it to work first and then we'll get it to scale" which
> is reasonable.

Just curious, what do you thinks about the rw-lock comments
from Esben in that a real rw-lock can't be deterministic ?

bill

