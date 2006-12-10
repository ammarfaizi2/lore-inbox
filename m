Return-Path: <linux-kernel-owner+w=401wt.eu-S1762444AbWLJW7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762444AbWLJW7Y (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 17:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762424AbWLJW7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 17:59:24 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:47769 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762384AbWLJW7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 17:59:23 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <457C913A.20600@s5r6.in-berlin.de>
Date: Sun, 10 Dec 2006 23:59:06 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
CC: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Import fw-ohci driver.
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com> <20061205052245.7213.39098.stgit@dinky.boston.redhat.com> <45750A89.7000802@garzik.org> <457A1A93.5090707@redhat.com> <457A663A.5080308@s5r6.in-berlin.de> <457C8075.4030000@redhat.com>
In-Reply-To: <457C8075.4030000@redhat.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Høgsberg wrote:
> Stefan Richter wrote:
>> Kristian Høgsberg wrote:
>>> Yup, I've done away with the bitfields and switched to a mix of __le16
>>> and __le32 struct fields.
>>
>> I suppose the struct should get __attribute__((packed)) then.
> 
> I guess it wouldn't harm, but is it really necessary?  Would gcc ever
> insert padding here, all the 32 bit fields a 32 bit aligned, and so are
> the 16 bit fields.

Is 2-byte alignment of 16bit struct members guaranteed on all platforms?

A related question:
If I specify a struct which, among else, contains 32bit quantities, then
any variable of this struct type is supposed to be at least 4-byte-aligned.
No if I specifiy this struct as packed, will variables of this type still
be aligned on 4 byte boundaries or will the compiler assume no alignment?
In other words, should it be __attribute__((packed,aligned(4))) then?
I'm speaking about situations where I not only wish to avoid unnecessarily
bad machine code due to unaligned access but where the device requires
4-byte alignment too.
-- 
Stefan Richter
-=====-=-==- ==-- -=-=-
http://arcgraph.de/sr/
