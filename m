Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422656AbWJLH2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422656AbWJLH2v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422783AbWJLH2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:28:51 -0400
Received: from ns1.suse.de ([195.135.220.2]:42214 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422656AbWJLH2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:28:50 -0400
Message-ID: <452DEEAB.3000403@suse.de>
Date: Thu, 12 Oct 2006 09:28:43 +0200
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
Cc: caglar@pardus.org.tr, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Avoid PIT SMP lockups
References: <1160170736.6140.31.camel@localhost.localdomain>	 <200610111349.32231.caglar@pardus.org.tr>	 <1160589556.5973.1.camel@localhost.localdomain>	 <200610112137.01160.caglar@pardus.org.tr> <1160592235.5973.5.camel@localhost.localdomain>
In-Reply-To: <1160592235.5973.5.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> Hey Gerd,
> 	Looks like the smp replacements code in 2.6.18 is breaking with vmware.
> I'm guessing we're taking an interrupt while apply_replacements is
> running. Any ideas?

Try switching the vmware configuration to "other OS".  This turns off
os-specific binary patching.  The alternatives code might have broken
assumptions vmware does about the linux kernel code ...

cheers,

  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
http://www.suse.de/~kraxel/julika-dora.jpeg
