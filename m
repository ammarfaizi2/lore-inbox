Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267214AbUBSMM4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 07:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267215AbUBSMM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 07:12:56 -0500
Received: from [195.23.16.24] ([195.23.16.24]:58003 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S267214AbUBSMMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 07:12:55 -0500
Message-ID: <4034A7F4.6000402@grupopie.com>
Date: Thu, 19 Feb 2004 12:11:32 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: tridge@samba.org
Cc: "Theodore Ts'o" <tytso@mit.edu>, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org
Subject: Re: UTF-8 and case-insensitivity
References: <1qqzv-2tr-3@gated-at.bofh.it>	<1qqJc-2A2-5@gated-at.bofh.it>	<1qHAR-2Wm-49@gated-at.bofh.it>	<1qIwr-5GB-11@gated-at.bofh.it>	<1qIwr-5GB-9@gated-at.bofh.it>	<1qIQ1-5WR-27@gated-at.bofh.it>	<1qIZt-6b9-11@gated-at.bofh.it>	<1qJsF-6Be-45@gated-at.bofh.it>	<E1Atbi7-0004tf-O7@localhost>	<16436.2817.900018.285167@samba.org>	<20040219024426.GA3901@thunk.org> <16436.11148.231014.822067@samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tridge@samba.org wrote:

> Currently dnotify doesn't give you the filename that is being
> added/deleted/renamed. It just tells you that something has happened,
> but not enough to actually maintain a name cache in user space.

This might be a crazy / stupid idea, so flame at will :)

Wouldn't it be possible to do a samba "super-server" mode, in which samba would 
assume that it controlled the directories it is exporting?

In this mode a "corporate" Samba server, serving Windows clients, could improve 
performance by assuming that its cache was always up-to-date.

If if we wanted to access the directory locally we could always mount locally 
using samba, and access the files anyway, albeit a lot slower and without linux 
permissions, etc.

What we would gain was the ability to say "I want to give priority to my samba 
server" (and set it to "super-server" mode) or "my priority is to the linux 
native filesystem, and just want to share my files with windows users anyway" 
(and keep using samba as always).

-- 
Paulo Marques - www.grupopie.com

"In a world without walls and fences who needs windows and gates?"

