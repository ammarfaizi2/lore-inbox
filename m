Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287333AbSAGXCY>; Mon, 7 Jan 2002 18:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287334AbSAGXCO>; Mon, 7 Jan 2002 18:02:14 -0500
Received: from tomts16.bellnexxia.net ([209.226.175.4]:13805 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S287333AbSAGXCA>; Mon, 7 Jan 2002 18:02:00 -0500
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: [PATCH] improving oom detection in rmap10c.
To: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Reply-To: tomlins@cam.org
Date: Mon, 07 Jan 2002 18:01:38 -0500
In-Reply-To: <Pine.LNX.4.33L.0201071635170.872-100000@imladris.surriel.com>
Organization: me
User-Agent: KNode/0.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20020107230138.BBE15AE10@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

> On Sun, 6 Jan 2002, Ed Tomlinson wrote:
> 
>> This patch should prevent oom situations where the vm does not see
>> pages released from the slab caches.
> 
>> Comments?
> 
> I have a feeling the OOM detection in rmap10c isn't working
> out because of another issue ... I think it has something to

I did not think this would solve all the OOM problems.  I do
think it will improve the situation in some instances.  The cost of
suppling the additional information is small - we do not want OOM
to trigger unless we really are OOM.  This patch can prevent the vm
from reporting some false OOMs...

Hope your audit discloses other problems.

Ed Tomlinson
