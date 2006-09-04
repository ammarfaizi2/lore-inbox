Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWIDWvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWIDWvj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 18:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWIDWvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 18:51:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:22021 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932219AbWIDWvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 18:51:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=IRq/c7YyETyxh56YDh7uDGfizxlAvLL4FyFedSpYX7DzM9WtQvCGRTKhK6eEnN59vYzpU9PJtxPVioR6JJJIXR5XFDlS/xgZ+JvEi40z+WuUb6oj6FSWS7eaWyq6eHj7C/PixRbDH6stooDxsuAawrCA5SaNe1/PB0iQZs6YC2c=
Date: Tue, 5 Sep 2006 02:51:33 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: venkatesh.pallipadi@intel.com
Subject: Re: + acpi-mwait-c-state-fixes.patch added to -mm tree
Message-ID: <20060904225133.GB5200@martell.zuzino.mipt.ru>
References: <200609040052.k840qK1Y003296@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609040052.k840qK1Y003296@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2006 at 05:52:20PM -0700, akpm@osdl.org wrote:
> The patch titled
>
>      acpi: mwait/C-state support
>
> has been added to the -mm tree.

> --- a/arch/i386/kernel/acpi/cstate.c~acpi-mwait-c-state-fixes
> +++ a/arch/i386/kernel/acpi/cstate.c

> +/* The code below handles cstate entry with monitor-mwait pair on Intel*/
> +
> +struct cstate_entry_s {

If suffix "_s" stands for "struct", it should be removed. You've already
typed "struct".

> +	struct {
> +		unsigned int eax;
> +		unsigned int ecx;
> +	} states[ACPI_PROCESSOR_MAX_POWER];
> +};

> +static inline void acpi_processor_ffh_cstate_enter(
> +		struct acpi_processor_cx *cstate)
> +{
> +	return;
> +}

Just
	{
	}

