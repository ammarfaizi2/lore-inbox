Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUF3UuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUF3UuI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 16:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbUF3UuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 16:50:08 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:17583 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262574AbUF3UuD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 16:50:03 -0400
Date: Wed, 30 Jun 2004 11:58:08 -0500
From: linas@austin.ibm.com
To: David Gibson <david@gibson.dropbear.id.au>, paulus@au1.ibm.com,
       paulus@samba.org, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64: lockfix for rtas error log
Message-ID: <20040630115808.R21634@forte.austin.ibm.com>
References: <20040629175007.P21634@forte.austin.ibm.com> <20040630011708.GG26251@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040630011708.GG26251@zax>; from david@gibson.dropbear.id.au on Wed, Jun 30, 2004 at 11:17:08AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2004 at 11:17:08AM +1000, David Gibson wrote:
> On Tue, Jun 29, 2004 at 05:50:07PM -0500, linas@austin.ibm.com wrote:
> > 
> > Paul,
> > 
> > Could you please apply the following path to the ameslab tree, and/or
> > forward it to the main 2.6 kernel maintainers.
> > 
> > This patch moves the location of a lock in order to protect
> > the contents of a buffer until it has been copied to its final
> > destination. Prior to this, a race existed whereby the buffer
> > could be filled even while it was being emptied.
> > 
> > Signed-off-by: Linas Vepstas <linas@linas.org>
> 
> Hmm... I note that log_error() does nothing but call ppc_md.log_error,
> and I can't see anywhere that that is set to be non-NULL...

grep log_error *.c
chrp_setup.c:   ppc_md.log_error = pSeries_log_error;

--linas

