Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030395AbVIAV0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030395AbVIAV0W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030397AbVIAV0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:26:22 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:62689 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030395AbVIAV0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:26:21 -0400
Message-ID: <431771EA.4030809@austin.ibm.com>
Date: Thu, 01 Sep 2005 16:26:02 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
Reply-To: jschopp@austin.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm1
References: <20050901035542.1c621af6.akpm@osdl.org> <6970000.1125584568@[10.10.2.4]> <20050901145006.GF5427@devserv.devel.redhat.com> <43176AE8.8060105@austin.ibm.com> <20050901211647.GC25405@devserv.devel.redhat.com>
In-Reply-To: <20050901211647.GC25405@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Try the diff below although I suspect much of the extra logic can go
> away and something like
> 
> 	len = tty_buffer_request_root(tty, HVCS_BUFF_LEN);
> 	if(len) {
> 		len = hvc_get_chars(...., len);
> 		tty_insert_flip_string(tty, buf, len);
> 	}
> 
> is better.

It's like whack a mole.  30 more now in drivers/serial/jsm/jsm_tty.c and 
  drivers/serial/icom.c

