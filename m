Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264000AbTJ1P07 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 10:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264001AbTJ1P07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 10:26:59 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:50915 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264000AbTJ1P06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 10:26:58 -0500
Message-ID: <3F9E8AB3.4070305@nortelnetworks.com>
Date: Tue, 28 Oct 2003 10:26:43 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Amir Hermelin <amir@montilio.com>, linux-kernel@vger.kernel.org
Subject: Re: how do file-mapped (mmapped) pages become dirty?
References: <006901c39d50$0b1313d0$2501a8c0@CARTMAN> <3F9E84A5.2060500@aitel.hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> Amir Hermelin wrote:

>> What function is responsible for this setting? And when will the page be
>> written back to disk (i.e. where's the flusher located)?
>>
> When there's memory pressure, or a sync.

Note however that you need an msync() -- fsync() and fdatasync() do not 
catch changes to mmapped pages.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

