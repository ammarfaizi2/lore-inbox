Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267236AbSKPGgp>; Sat, 16 Nov 2002 01:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267237AbSKPGgp>; Sat, 16 Nov 2002 01:36:45 -0500
Received: from holomorphy.com ([66.224.33.161]:54227 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267236AbSKPGgp>;
	Sat, 16 Nov 2002 01:36:45 -0500
Date: Fri, 15 Nov 2002 22:41:05 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH] 2.5.47: strdup()
Message-ID: <20021116064105.GF23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
References: <87d6p63ui2.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d6p63ui2.fsf@goat.bogus.local>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2002 at 07:21:09AM +0100, Olaf Dietsche wrote:
+	char *p = kmalloc(strlen(s) + 1, GFP_KERNEL);

I'm very concerned the implicit allocation will be abused and OOM
highmem boxen. Can you at least optionally highmem-allocate the buffers?


Thanks,
Bill
