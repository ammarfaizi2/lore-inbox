Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWBJEsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWBJEsI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 23:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWBJEsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 23:48:08 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:29906
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751081AbWBJEsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 23:48:06 -0500
Date: Thu, 9 Feb 2006 20:47:54 -0800
From: Greg KH <greg@kroah.com>
To: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       kaber@trash.net
Subject: Re: [stable] Re: [patch 6/6] [NETFILTER]: Fix another crash in ip_nat_pptp (CVE-2006-0037)
Message-ID: <20060210044754.GC27457@kroah.com>
References: <20060128015840.722214000@press.kroah.org> <20060128021835.GG10362@kroah.com> <20060208123541.GA6004@kruemel.my-eitzenberger.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208123541.GA6004@kruemel.my-eitzenberger.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 01:35:41PM +0100, Holger Eitzenberger wrote:
> On Fri, Jan 27, 2006 at 06:18:35PM -0800, Greg KH wrote:
> 
> >  	DEBUGP("altering call id from 0x%04x to 0x%04x\n",
> > -		ntohs(*cid), ntohs(new_callid));
> > +		ntohs(*(u_int16_t *)pptpReq + cid_off), ntohs(new_callid));
> 
> Note that this fix introduces another bug in the above use DEBUGP
> statement, as there is (u_int16_t *) ptr arithmetic used, whereas
> cid_off is a byte offset.
> 
> A fix for that was send a few weeks ago on netfilter-devel.

Great, care to forward it to stable@kernel.org so we can get it in the
next release?

thanks,

greg k-h
