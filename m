Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbUCQVrM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 16:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbUCQVrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 16:47:12 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:39097 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262089AbUCQVqF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 16:46:05 -0500
Date: Wed, 17 Mar 2004 13:44:34 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: Matthias Andree <ma+lscsi@dt.e-technik.uni-dortmund.de>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.5-rc1 SCSI + st regressions (was: Linux 2.6.5-rc1)
Message-ID: <20040317214434.GF949@beaverton.ibm.com>
Mail-Followup-To: Kai Makisara <Kai.Makisara@kolumbus.fi>,
	Matthias Andree <ma+lscsi@dt.e-technik.uni-dortmund.de>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg KH <greg@kroah.com>
References: <Pine.LNX.4.58.0403152154070.19853@ppc970.osdl.org> <20040316211203.GA3679@merlin.emma.line.org> <20040316211700.GA25059@parcelfarce.linux.theplanet.co.uk> <20040316215659.GA3861@merlin.emma.line.org> <Pine.LNX.4.58.0403172145420.1093@kai.makisara.local> <Pine.LNX.4.58.0403172312410.1093@kai.makisara.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403172312410.1093@kai.makisara.local>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Makisara [Kai.Makisara@kolumbus.fi] wrote:
>  		if (!st_class_member) {
>  			printk(KERN_WARNING "st%d: class_simple_device_add failed\n",
>  			       dev_num);

Could you change the if check to use IS_ERR(st_class_member) so in the
future if do_create_class_files return -E* we will not get a oops.

-andmike
--
Michael Anderson
andmike@us.ibm.com

