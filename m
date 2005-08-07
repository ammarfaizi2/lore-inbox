Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752859AbVHGVx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbVHGVx7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 17:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752860AbVHGVx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 17:53:59 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:36600 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752859AbVHGVx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 17:53:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=BmMdWjeJeoICfjxfjL8Q6OwGPlPVuU5wOXYHjnRYeIQiQ3miMOrFbOSkybaQRGadGPABqfIMMUyev19CZ2QqmeWZz6niV9qaBuvI6fD3vSu840V4NjiYrUhIpJW/gVARCPfnZc/zW5ZbKS9E1ueCSo69PYZ+VXehv6CJjW4EyAk=
Message-ID: <42F682AE.2010803@gmail.com>
Date: Sun, 07 Aug 2005 17:52:46 -0400
From: Keenan Pepper <keenanpepper@gmail.com>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: synchronize_rcu vs. rcu_barrier
References: <42F66E81.2020807@gmail.com>
In-Reply-To: <42F66E81.2020807@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What's the difference between synchronize_rcu() and rcu_barrier() (new 
> function used only by reiser4 code)? From the scant documentation it 
> seems like they do the same thing.

I'm now happily running 2.6.13-rc4-rt-v0.7.52-14-reiser4 which I compiled by adding

#define rcu_barrier synchronize_rcu

so there must not be that much difference =) (at least on UP, that is).

Keenan
