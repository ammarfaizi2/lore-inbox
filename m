Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbVGTEtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVGTEtf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 00:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVGTEtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 00:49:35 -0400
Received: from host218.bellglobal.com ([204.101.166.218]:39691 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261726AbVGTEte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 00:49:34 -0400
Date: Wed, 20 Jul 2005 00:26:22 -0400
From: Greg KH <greg@kroah.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Subject: Re: [PATCH 2.6] I2C: Separate non-i2c hwmon drivers from i2c-core (1/9)
Message-ID: <20050720042622.GC26552@kroah.com>
References: <20050719233902.40282559.khali@linux-fr.org> <20050719234540.78a3f8ea.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050719234540.78a3f8ea.khali@linux-fr.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2005 at 11:45:40PM +0200, Jean Delvare wrote:
> +/* Next four are needed by i2c-isa */
> +EXPORT_SYMBOL(i2c_adapter_dev_release);
> +EXPORT_SYMBOL(i2c_adapter_driver);
> +EXPORT_SYMBOL(i2c_adapter_class);
> +EXPORT_SYMBOL(i2c_bus_type);

EXPORT_SYMBOL_GPL() instead?  As these were, core, GPL only symbols
before you exported them.

thanks,

greg k-h
