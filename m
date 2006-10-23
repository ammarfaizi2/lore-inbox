Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbWJWS0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbWJWS0o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 14:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbWJWS0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 14:26:44 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:14989 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S964995AbWJWS0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 14:26:43 -0400
Date: Mon, 23 Oct 2006 19:26:35 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, olpc-dev@laptop.org, davidz@redhat.com,
       greg@kroah.com, len.brown@intel.com, sfr@canb.auug.org.au,
       benh@kernel.crashing.org
Subject: Re: Battery class driver.
Message-ID: <20061023182635.GA19139@srcf.ucam.org>
References: <1161627633.19446.387.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161627633.19446.387.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 07:20:33PM +0100, David Woodhouse wrote:

> +BATTERY_DEVICE_ATTR("temp1",TEMP1,milli);
> +BATTERY_DEVICE_ATTR("temp1_name",TEMP1_NAME,string);
> +BATTERY_DEVICE_ATTR("temp2",TEMP2,milli);
> +BATTERY_DEVICE_ATTR("temp2_name",TEMP2_NAME,string);
> +BATTERY_DEVICE_ATTR("voltage",VOLTAGE,milli);
> +BATTERY_DEVICE_ATTR("voltage_design",VOLTAGE_DESIGN,milli);
> +BATTERY_DEVICE_ATTR("current",CURRENT,milli);
> +BATTERY_DEVICE_ATTR("charge_rate",CHARGE_RATE,milli);
> +BATTERY_DEVICE_ATTR("charge_max",CHARGE_MAX,milli);
> +BATTERY_DEVICE_ATTR("charge_last",CHARGE_LAST,milli);
> +BATTERY_DEVICE_ATTR("charge_low",CHARGE_LOW,milli);
> +BATTERY_DEVICE_ATTR("charge_warn",CHARGE_WARN,milli);
> +BATTERY_DEVICE_ATTR("charge_unit",CHARGE_UNITS,string);
> +BATTERY_DEVICE_ATTR("charge_percent",CHARGE_PCT,int);
> +BATTERY_DEVICE_ATTR("time_remaining",TIME_REMAINING,int);
> +BATTERY_DEVICE_ATTR("manufacturer",MANUFACTURER,string);
> +BATTERY_DEVICE_ATTR("technology",TECHNOLOGY,string);
> +BATTERY_DEVICE_ATTR("model",MODEL,string);
> +BATTERY_DEVICE_ATTR("serial",SERIAL,string);
> +BATTERY_DEVICE_ATTR("type",TYPE,string);
> +BATTERY_DEVICE_ATTR("oem_info",OEM_INFO,string);

Without commenting on the rest:

The tp_smapi code also provides average current and power, the charge 
cycle count, the date of first use, the date of manufacture and controls 
for altering the charge behaviour of the battery. Are these things that 
should go in the generic class?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
