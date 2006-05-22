Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWEVRv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWEVRv4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 13:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWEVRv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 13:51:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50088 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751091AbWEVRv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 13:51:56 -0400
Date: Mon, 22 May 2006 13:55:27 -0400
From: Don Zickus <dzickus@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de,
       oprofile-list@lists.sourceforge.net
Subject: Re: [patch 5/8] Add SMP support on i386 to reservation framework
Message-ID: <20060522175527.GD15669@redhat.com>
References: <20060509205035.446349000@drseuss.boston.redhat.com> <20060509205957.466442000@drseuss.boston.redhat.com> <87mzdage4i.fsf@pike.pond.sub.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mzdage4i.fsf@pike.pond.sub.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2006 at 07:31:41PM +0200, Markus Armbruster wrote:
> @@ -457,143 +434,312 @@ late_initcall(init_lapic_nmi_sysfs);
> [...]
>  static int setup_p6_watchdog(void)
> [...]
>  	apic_write(APIC_LVTPC, APIC_DM_NMI);
> -	evntsel |= P6_EVNTSEL0_ENABLE;
> -	wrmsr(MSR_P6_EVNTSEL0, evntsel, 0);
> +	evntsel |= K7_EVNTSEL_ENABLE;
> 
> Me thinks you want P6_EVNTSEL0_ENABLE here, although the value is the
> same.

Yup, the downside of copying/pasting...

Thanks.


