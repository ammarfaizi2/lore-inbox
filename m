Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbVCIQEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVCIQEw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 11:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVCIQEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 11:04:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:65261 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261951AbVCIQCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 11:02:19 -0500
Subject: Re: badness in interruptible_sleep_on_timeout FC-3 (source code
	and Makefile attached)
From: Arjan van de Ven <arjan@infradead.org>
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
Cc: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB348113A48C2@mail.esn.co.in>
References: <4EE0CBA31942E547B99B3D4BFAB348113A48C2@mail.esn.co.in>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 17:02:14 +0100
Message-Id: <1110384134.6280.127.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-09 at 20:12 +0530, Srinivas G. wrote:
> 
> 
> I have developed a small module in Fedora Core 3 with 2.6.9-1.667
> kernel
> version. This module uses the interruptible_sleep_on_timeout call and

don't use interruptible_sleep_on_timeout() !!!!
really. 

(and if you want to use the sleep_on() family of apis even when you
shouldn't, you HAVE to hold the big kernel lock for them!)

