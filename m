Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVDMJ4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVDMJ4I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 05:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVDMJ4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 05:56:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:64975 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261286AbVDMJ4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 05:56:06 -0400
Subject: Re: EXPORT_SYMBOL_GPL for __symbol_get replacing EXPORT_SYMBOL for
	deprecated inter_module_get
From: Arjan van de Ven <arjan@infradead.org>
To: Yuri Vilmanis <vilmanis@internode.on.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200504131855.00806.vilmanis@internode.on.net>
References: <200504131855.00806.vilmanis@internode.on.net>
Content-Type: text/plain
Date: Wed, 13 Apr 2005 11:56:00 +0200
Message-Id: <1113386160.6275.44.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
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

On Wed, 2005-04-13 at 18:55 +0930, Yuri Vilmanis wrote:
> I believe that, in general, new functions which replace deprecated functions 
> which were exported as EXPORT_SYMBOL, should also be exported as 
> EXPORT_SYMBOL, not as EXPORT_SYMBOL_GPL. The reason I say this is because 
> deprecation of old functions breaks old modules and drivers that use them, 
> and changing the level of GPL strictness of the function prevents these old 
> modules being updated and used with newer kernels.
> 
> The case in point for me is ATI's binary openGL accelerated drivers (fglrx) - 
> these used inter_module_get() to communicate with the agp gart module, 

except that the AGP gart module no longer uses inter_module_*


> for 
> obvious reasons - this AGP communication is essential to the functionality of 
> the driver.

this is thus non-obvious..




> The case of inter_module_get deprecation and replacement with symbol_get 

inter_module_get is absolutely not replaced by symbol_get. They are
entirely different usages and only have a few letters in common in the
name.



