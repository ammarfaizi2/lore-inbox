Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbULVQFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbULVQFt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 11:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbULVQFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 11:05:41 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:60681 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262002AbULVQFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 11:05:24 -0500
Date: Wed, 22 Dec 2004 11:06:27 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Martijn van Oosterhout <kleptog@svana.org>
Cc: Mandeep Sandhu <Mandeep_Sandhu@infosys.com>, dima@s2io.com,
       Jeff Garzik <jgarzik@pobox.com>, linux-newbie@vger.kernel.org,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       kernelnewbies <kernelnewbies@nl.linux.org>
Subject: Re: zero copy issue while receiving the data (counter part of sendfil e)
Message-ID: <20041222160625.GB19449@tuxdriver.com>
Mail-Followup-To: Martijn van Oosterhout <kleptog@svana.org>,
	Mandeep Sandhu <Mandeep_Sandhu@infosys.com>, dima@s2io.com,
	Jeff Garzik <jgarzik@pobox.com>, linux-newbie@vger.kernel.org,
	linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernelnewbies <kernelnewbies@nl.linux.org>
References: <267988DEACEC5A4D86D5FCD780313FBB02C66FCA@exch-03.noida.hcltech.com> <1103649767.7217.100.camel@beastie> <41C879CB.3040600@pobox.com> <1103658190.7217.121.camel@beastie> <1103703718.3775.93.camel@samish.india.ascend.com> <20041222155003.GA29278@svana.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041222155003.GA29278@svana.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 04:50:05PM +0100, Martijn van Oosterhout wrote:

> Generally, reading from memory takes time because the CPU has to wait,
> writing is free since it can be deferred in the cache (in theory
> indefinitly) until there's free cycle.

I'm not sure I'd call that "free" -- executing the instructions for
the write has a non-zero cost.

Still, it is significantly cheaper than the read...

John
-- 
John W. Linville
linville@tuxdriver.com
