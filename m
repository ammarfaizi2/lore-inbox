Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbVIVJo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbVIVJo3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 05:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbVIVJo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 05:44:29 -0400
Received: from colin.muc.de ([193.149.48.1]:36871 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1030238AbVIVJo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 05:44:28 -0400
Date: 22 Sep 2005 11:44:19 +0200
Date: Thu, 22 Sep 2005 11:44:19 +0200
From: Andi Kleen <ak@muc.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, discuss@x86-64.org
Subject: Re: Dont use shortcut when using send_IPI_all in flat mode
Message-ID: <20050922094419.GA79762@muc.de>
References: <20050921135215.A14439@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050921135215.A14439@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 01:52:16PM -0700, Ashok Raj wrote:
> Hi
> 
> This got missed during the previous update for not doing shortcut 
> since it introduces race in IPI, when using flat mode.
> 
> The earlier patches addressed send_IPI_allbutself, this one
> take care of the sendall() case as well.
> 
> Andrew: Please consider for -mm

It's not needed because genapic always sets physflat when 
CONFIG_HOTPLUG_CPU is set.

In fact the other HOTPLUG_CPU ifdefs in genapic_flat you added
can be removed now.

-Andi
