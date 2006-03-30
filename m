Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWC3AMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWC3AMa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 19:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWC3AMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 19:12:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3050 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750794AbWC3AM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 19:12:29 -0500
Date: Wed, 29 Mar 2006 16:13:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: ashok.raj@intel.com, pavel@ucw.cz, linux-kernel@vger.kernel.org,
       rjw@sisk.pl
Subject: Re: [rfc] fix Kconfig, hotplug_cpu is needed for swsusp
Message-Id: <20060329161354.3ce3d71b.akpm@osdl.org>
In-Reply-To: <200603300953.32298.ncunningham@cyclades.com>
References: <20060329220808.GA1716@elf.ucw.cz>
	<200603300936.22757.ncunningham@cyclades.com>
	<20060329154748.A12897@unix-os.sc.intel.com>
	<200603300953.32298.ncunningham@cyclades.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@cyclades.com> wrote:
>
> I think it's better to use selects. 
> I reckon that if the user selects SMP and then selects suspend support, 
> everything else required should be automatic.

Yes.  `select' is end-user-friendly but kernel-developer-hostile. 
Sometimes it's infuriating trying to work out why a symbol keeps on getting
turned on.

<checks>

hm, menuconfig's "/" command does show "Selected by:".  That helps.
