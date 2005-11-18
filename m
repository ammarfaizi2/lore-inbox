Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbVKRHML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbVKRHML (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 02:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbVKRHML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 02:12:11 -0500
Received: from isilmar.linta.de ([213.239.214.66]:40168 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932553AbVKRHMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 02:12:09 -0500
Date: Fri, 18 Nov 2005 08:12:08 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: davej@redhat.com, hugh@veritas.com, akpm@osdl.org, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] unpaged: private write VM_RESERVED
Message-ID: <20051118071208.GA15705@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	"David S. Miller" <davem@davemloft.net>, davej@redhat.com,
	hugh@veritas.com, akpm@osdl.org, nickpiggin@yahoo.com.au,
	linux-kernel@vger.kernel.org
References: <20051117194102.GE5772@redhat.com> <20051117204617.GA10925@isilmar.linta.de> <20051117205156.GH5772@redhat.com> <20051117.155856.44665420.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117.155856.44665420.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 17, 2005 at 03:58:56PM -0800, David S. Miller wrote:
> > Davem's initial analysis was on ddcprobe, it's possible that whilst the
> > code is the same in both projects, that vbetool's needs are different
> > enough to require a different patch.
> 
> I don't think so, but lrmi.c instances are doing exactly the
> same stuff so the same fix ought to work in both spots.
> 
> It could be some other 2.6.15 change that's mucked up suspend-to-ram
> resume for this person.

No. 2.6.15-rc1-git-as-of-yesterday and Hugh's patches plus original
vbetool-0.3 works fine, but it plus vbetool-0.3-lrmi.patch breaks resume for
this person's notebook, i.e. mine. And it's repeatable.

	Dominik
