Return-Path: <linux-kernel-owner+w=401wt.eu-S933840AbWLJVsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933840AbWLJVsu (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 16:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934424AbWLJVsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 16:48:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55701 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933840AbWLJVst convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 16:48:49 -0500
Message-ID: <457C8075.4030000@redhat.com>
Date: Sun, 10 Dec 2006 16:47:33 -0500
From: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
CC: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Import fw-ohci driver.
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com> <20061205052245.7213.39098.stgit@dinky.boston.redhat.com> <45750A89.7000802@garzik.org> <457A1A93.5090707@redhat.com> <457A663A.5080308@s5r6.in-berlin.de>
In-Reply-To: <457A663A.5080308@s5r6.in-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter wrote:
> Kristian Høgsberg wrote:
>> Yup, I've done away with the bitfields and switched to a mix of __le16
>> and __le32 struct fields.
> 
> I suppose the struct should get __attribute__((packed)) then.

I guess it wouldn't harm, but is it really necessary?  Would gcc ever insert 
padding here, all the 32 bit fields a 32 bit aligned, and so are the 16 bit 
fields.

> But is the order of two adjacent __le16 fields (i.e. two halves of a
> quadlet) independent of host byte order?

Yeah, it works for both be and le cpus.  The layout is le specific, which is 
how the host controller wants it.

cheers,
Kristian

