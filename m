Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWE3ORY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWE3ORY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 10:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWE3ORY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 10:17:24 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:16652 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932165AbWE3ORX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 10:17:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EQX3Uek2UtddoQIPanQIYMSQnhlKe9MCLK3Fk3cAgDzIRxXq5P+ieItRyQNyF2f9yhZ7WeTM1Ne/9qfaiBWshpwdm82Vlz1WHsjutH/tK2jiCHywc8ZO0i+zN7Lg7Cws7GoJeNA+0tPsU1jFO/57kaSNZ06Ry6InQk1Xs2W7uKY=
Message-ID: <b0943d9e0605300717w432523b9j31c03d2c216d159b@mail.gmail.com>
Date: Tue, 30 May 2006 15:17:21 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc5 0/7] Kernel memory leak detector 0.3
In-Reply-To: <20060530135016.21491.34817.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060530135016.21491.34817.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/06, Catalin Marinas <catalin.marinas@arm.com> wrote:
> This is a new version (0.3) of the kernel memory leak detector.

I forgot to mention - the kernels with this patch and the config
option enabled cannot be compiled with gcc4 because of a compiler bug
that always returns "true" for __builtin_constant_p(), even if its
argument can only be determined at run-time. This causes a few
compilation errors on the container_of usage.

-- 
Catalin
