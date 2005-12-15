Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVLOQna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVLOQna (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 11:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbVLOQna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 11:43:30 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:63952 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1750806AbVLOQna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 11:43:30 -0500
Message-ID: <43A19D2A.4060005@oracle.com>
Date: Thu, 15 Dec 2005 08:43:22 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: akpm@odsl.org, linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [AIO] reorder kiocb structure elements to make sync iocb setup
 faster
References: <20051215154357.GC2444@kvack.org>
In-Reply-To: <20051215154357.GC2444@kvack.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> The patch below reorders members of the kiocb structure to make sync kiocb 
> setup faster.  By setting the elements sequentially, the write combining 
> buffers on the CPU are able to combine the writes into a single burst, 

Seems reasonable, but can we get comments in both the struct and where
it's initialized explaining this coordination?

- z
