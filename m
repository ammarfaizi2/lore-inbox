Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267370AbUIFAmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267370AbUIFAmj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 20:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267374AbUIFAmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 20:42:39 -0400
Received: from ns1.skjellin.no ([80.239.42.66]:30399 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S267370AbUIFAmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 20:42:36 -0400
Message-ID: <413BB200.4010708@tomt.net>
Date: Mon, 06 Sep 2004 02:40:32 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rohit Neupane <rohitneupane@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Weird Problem with TCP
References: <93e09f0104090202216403c08d@mail.gmail.com> <1094122617.4966.0.camel@localhost.localdomain> <93e09f0104090206334a708289@mail.gmail.com>
In-Reply-To: <93e09f0104090206334a708289@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Neupane wrote:
> No, it is not running any session tracking (ip_conntrack) neither it
> does nat. It is just a firewall with around 1600 rules in FORWARD
> mangle table and around 1500 rules in FORWARD filter table. Out of
> 1500 rules , 1377 rules are MAC filter rules.
> And it had 3 alias address for the interface conneted to the wirelss.

Ouch. Thats a lot of rules to traverse for each packet. Segment them 
into chains if possible. Also you may want to take a look at nf-hipac, 
http://www.hipac.org

-- 
André Tomt
