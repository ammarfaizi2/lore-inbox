Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263820AbUDNHCa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 03:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263927AbUDNHCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 03:02:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22502 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263820AbUDNHC3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 03:02:29 -0400
Date: Wed, 14 Apr 2004 08:02:27 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: [RFC] fix sysfs symlinks
Message-ID: <20040414070227.GA31500@parcelfarce.linux.theplanet.co.uk>
References: <20040413124037.GA21637@in.ibm.com> <20040413133615.GZ31500@parcelfarce.linux.theplanet.co.uk> <20040414064015.GA4505@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040414064015.GA4505@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2004 at 12:10:16PM +0530, Maneesh Soni wrote:
> I am not sure, if pinning the kobject for the life time of symlink (dentry)
> may result in same problems like rmmod hang which we saw in case of pinning
> kobject for the life time of its directory (dentry).

Erm...  If rmmod _ever_ waits for refcount on kobject to reach zero, it's
already broken.  Do you have any examples of such behaviour?
 
> +	pr_debug("%s: path = '%s'\n", __FUNCTION__, path);
> +
> +	return error;

ITYM
	return 0;

BTW, replace leading spaces with tab, please - you've got a tabdamage
very visible in patch.
