Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbUFJSpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUFJSpY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 14:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbUFJSpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 14:45:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14999 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262370AbUFJSpV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 14:45:21 -0400
Date: Thu, 10 Jun 2004 19:45:20 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net,
       "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Finding user/kernel pointer bugs [no html]
Message-ID: <20040610184520.GI12308@parcelfarce.linux.theplanet.co.uk>
References: <1086838266.32059.320.camel@dooby.cs.berkeley.edu> <20040610044903.GE12308@parcelfarce.linux.theplanet.co.uk> <20040610165821.GB32577@kroah.com> <20040610183442.GA1271@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040610183442.GA1271@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2004 at 11:34:42AM -0700, Greg KH wrote:
>  	struct usb_mixerdev *ms = (struct usb_mixerdev *)file->private_data;
>  	int i, j, val;
> +	int __user *int_user_arg = (int __user *)arg;

Egads...  How about changing the name to something that would not be so
scary?
