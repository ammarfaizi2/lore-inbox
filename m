Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267561AbTGVT1m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 15:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270876AbTGVT1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 15:27:42 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:18215 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S267561AbTGVTZi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 15:25:38 -0400
Message-ID: <3F1D91F0.2020900@rackable.com>
Date: Tue, 22 Jul 2003 12:35:12 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Christoph Hellwig <hch@infradead.org>,
       James Simmons <jsimmons@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>, Charles Lepple <clepple@ghz.cc>,
       michaelm <admin@www0.org>, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Subject: Re: Make menuconfig broken
References: <Pine.LNX.4.44.0307221146120.714-100000@serv> <Pine.LNX.4.44.0307221735160.5483-100000@phoenix.infradead.org> <20030722191746.A13975@infradead.org> <20030722191646.GB2003@mars.ravnborg.org>
In-Reply-To: <20030722191646.GB2003@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jul 2003 19:40:35.0718 (UTC) FILETIME=[1EFD8A60:01C35089]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:

>On Tue, Jul 22, 2003 at 07:17:46PM +0100, Christoph Hellwig wrote:
>  
>
>>If you really want that do it a a separate make updateconfig script instead
>>of bloating make oldconfig.
>>    
>>
>
>updateconfig is definetely more acceptable than bloating oldconfig.
>But would we end up with lots of hacks - and where do we stop.
>Do we want to go the whole way back to a 2.0 .config and do an
>acceptable .config using:
>make updateconfig
>
>Or is this limited to 2.4 -> 2.6?
>
>	Sam
>  
>

  Well there are 2 issues here:

1) How to handle "make oldconfig" on 2.4 config files.  Which may not be 
fixable in a manner that doesn't involve really ugly code.

2) That make menuconfig|xconfig on a clean 2.6 tree results in a kernel 
that doesn't have console support.   This will be something that will 
come up over and over again in the future, and does not require ugly 
hacks to fix.

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


