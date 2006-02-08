Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965190AbWBHW0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965190AbWBHW0E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 17:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965196AbWBHW0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 17:26:03 -0500
Received: from ip-svs-1.Informatik.Uni-Oldenburg.DE ([134.106.12.126]:40405
	"EHLO aechz.svs.informatik.uni-oldenburg.de") by vger.kernel.org
	with ESMTP id S965190AbWBHW0A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 17:26:00 -0500
Date: Wed, 8 Feb 2006 23:25:32 +0100
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Message-ID: <20060208222532.GA4824@titan.lahn.de>
Mail-Followup-To: Matthew Garrett <mjg59@srcf.ucam.org>,
	linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060208125753.GA25562@srcf.ucam.org> <20060208130422.GB25659@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208130422.GB25659@srcf.ucam.org>
Organization: UUCP-Freunde Lahn e.V.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, Feb 08, 2006 at 01:04:22PM +0000, Matthew Garrett wrote:
> diff --git a/include/linux/pm.h b/include/linux/pm.h
...
> +void pm_set_ac_status(int (*ac_status_function)(void))
> +{
> +	down(&pm_sem);
> +	get_ac_status = ac_status_function;
> +	up(&pm_sem);
> +}

Why do you need a semaphore/mutex, when you only do one assignment,
which is atomic by itself?

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
