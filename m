Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWAKJWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWAKJWN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 04:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWAKJWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 04:22:12 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:22949 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750822AbWAKJWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 04:22:12 -0500
Subject: Re: [2.6 patch] arch/s390/Makefile: remove -finline-limit=10000
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Adrian Bunk <bunk@stusta.de>
Cc: linux390@de.ibm.com, linux-390@vm.marist.edu, linux-kernel@vger.kernel.org
In-Reply-To: <20060110205704.GD3911@stusta.de>
References: <20060110205704.GD3911@stusta.de>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 10:21:20 +0100
Message-Id: <1136971280.6147.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-10 at 21:57 +0100, Adrian Bunk wrote:
> -finline-limit might have been required for older compilers, but 
> nowadays it does no longer make sense.

I didn't check the effects of reverting to the default inline-limit, did
you find any negative impacts? I'm thinking about the critical code
paths e.g. minor faults. There better should not be an additional
function call that would have been inlined with the bigger inline limit,
since function calls are quite expensive on s390.

-- 
blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


