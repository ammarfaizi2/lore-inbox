Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWGMN2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWGMN2Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 09:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWGMN2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 09:28:25 -0400
Received: from mx1.suse.de ([195.135.220.2]:19584 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751472AbWGMN2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 09:28:24 -0400
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] IDE: Touch NMI watchdog during resume from STR
References: <44B61D0A.7010305@stud.feec.vutbr.cz>
From: Andi Kleen <ak@suse.de>
Date: 13 Jul 2006 15:28:17 +0200
In-Reply-To: <44B61D0A.7010305@stud.feec.vutbr.cz>
Message-ID: <p73ejwpmy6m.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Schmidt <xschmi00@stud.feec.vutbr.cz> writes:
> if (stat == 0xff)
>  			return -ENODEV;
>  		touch_softlockup_watchdog();
> +		touch_nmi_watchdog();
You can remove the touch_softlock_watchdog then. It's implied in 
touch_nmi_watchdog

-Andi
