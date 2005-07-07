Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVGGI3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVGGI3M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 04:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVGGI1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 04:27:15 -0400
Received: from gate.corvil.net ([213.94.219.177]:16140 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S261244AbVGGI0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 04:26:44 -0400
Message-ID: <42CCE737.70802@draigBrady.com>
Date: Thu, 07 Jul 2005 09:26:31 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: How do you accurately determine a process' RAM usage?
References: <42CC2923.2030709@draigBrady.com> <20050706181623.3729d208.akpm@osdl.org>
In-Reply-To: <20050706181623.3729d208.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Calculating this stuff accurately is very expensive.  You'll get a better
> answer using proc-pid-smaps.patch from -mm, but even that won't tell you
> things about sharing levels of the pages.

Great, thanks! I'll play around with this:
http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc1/2.6.13-rc1-mm1/broken-out/proc-pid-smaps.patch
Looks like it's been stable for 4 months?

Given that it's an independent /proc/$pid/smaps file,
it only needs to be queried when required and so
I wouldn't worry too much about cost. `top` wouldn't use it
for e.g., but specialised tools like mine would.

-- 
Pádraig Brady - http://www.pixelbeat.org
--
