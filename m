Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267610AbUHRXY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267610AbUHRXY4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 19:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267614AbUHRXY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 19:24:56 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:47878 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267610AbUHRXYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 19:24:54 -0400
Date: Thu, 19 Aug 2004 00:24:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: hch@infradead.org, alan@lxorguk.ukuu.org.uk, wtogami@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: Merge I2O patches from -mm
Message-ID: <20040819002448.A3905@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Markus Lidel <Markus.Lidel@shadowconnect.com>,
	alan@lxorguk.ukuu.org.uk, wtogami@redhat.com,
	linux-kernel@vger.kernel.org
References: <4123E171.3070104@shadowconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4123E171.3070104@shadowconnect.com>; from Markus.Lidel@shadowconnect.com on Thu, Aug 19, 2004 at 01:08:33AM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 01:08:33AM +0200, Markus Lidel wrote:
> Okay, patch i2o_scsi-cleanup.patch adds a notification facility to the 
> i2o_driver, which notify if a controller is added or removed. The 
> i2o_controller structure has now the ability to store per-driver data 
> and the SCSI-OSM now takes advantage of this. So all ugly parts should 
> be removed now :-)
> 
> If you have further things which should be changed, please let me know...

Looks much better now, thanks.  But instead of the notify call please
add a controller_add and add controller_remove method, taking a typesafe
i2o_controller * instead of the multiplexer.

> 
> 
> 
> Best regards,
> 
> 
> Markus Lidel
> ------------------------------------------
> Markus Lidel (Senior IT Consultant)
> 
> Shadow Connect GmbH
> Carl-Reisch-Weg 12
> D-86381 Krumbach
> Germany
> 
> Phone:  +49 82 82/99 51-0
> Fax:    +49 82 82/99 51-11
> 
> E-Mail: Markus.Lidel@shadowconnect.com
> URL:    http://www.shadowconnect.com


---end quoted text---
