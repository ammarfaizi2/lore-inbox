Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271212AbTHCPfa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 11:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271222AbTHCPfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 11:35:30 -0400
Received: from dm1-11.slc.aros.net ([66.219.220.11]:46012 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S271212AbTHCPf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 11:35:26 -0400
Message-ID: <3F2D2BBA.70205@aros.net>
Date: Sun, 03 Aug 2003 09:35:22 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Manfred Spraul <manfred@colorfullife.com>, Jens Axboe <axboe@suse.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: IDE locking problem
References: <3F2D1884.3010001@colorfullife.com> <1059920721.3524.137.camel@gaston>
In-Reply-To: <1059920721.3524.137.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

>>The last step is bad - sooner or later the queue will be kfreed, and if 
>>there are bozos around that still have references, they would access 
>>random memory. It must be guaranteed that all references expired before 
>>the tear down begins. Just leaving a dead flag set is not sufficient.
>>    
>>
>Jens ? I see no refcounting of the queue,. . .
>
struct request_queue's kobj field perhaps?

