Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262540AbVBXXX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbVBXXX3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 18:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbVBXXX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 18:23:29 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:58274 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262540AbVBXXXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 18:23:10 -0500
Message-ID: <421E61CC.5090302@nortel.com>
Date: Thu, 24 Feb 2005 17:22:52 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Chad N. Tindel" <chad@tindel.net>, helge.hafting@aitel.hist.no,
       linux-kernel@vger.kernel.org
Subject: Re: Xterm Hangs - Possible scheduler defect?
References: <20050223230639.GA33795@calma.pair.com>	<20050223183634.31869fa6.akpm@osdl.org>	<20050224052630.GA99960@calma.pair.com>	<421DD5CC.5060106@aitel.hist.no>	<20050224173356.GA11593@calma.pair.com> <20050224150026.69b1862f.akpm@osdl.org>
In-Reply-To: <20050224150026.69b1862f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> #!/bin/sh
> 
> PIDS=$(ps axo pid,command | grep ' \[.*\]$' | sed -e 's/ \[.*\]$//')
> 
> for i in $PIDS
> do
> 	chrt -r 99 -9 $i
> done


For the unaware, "chrt" is part of the schedutils package. (I didn't 
know about it till just now...figured I'd save others the trouble of 
searching.)

Chris

