Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754266AbWKMIKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266AbWKMIKW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 03:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754272AbWKMIKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 03:10:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:65168 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1754265AbWKMIKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 03:10:21 -0500
Subject: Re: [2.6 patch] arch/i386/kernel/io_apic.c: handle a negative
	return value
From: Ingo Molnar <mingo@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061112174826.GC3382@stusta.de>
References: <20061112174826.GC3382@stusta.de>
Content-Type: text/plain
Date: Mon, 13 Nov 2006 09:08:31 +0100
Message-Id: <1163405311.7473.48.camel@earth>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-12 at 18:48 +0100, Adrian Bunk wrote:
> The Coverity checker noted that bad things might happen if 
> find_isa_irq_apic() returned -1.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

hm, it seems the checker did not notice the following:
find_isa_irq_apic() can return -1 /only/ if find_isa_irq_pin() returns
-1 too. So this is not a bug - it's rather a bit unclean code (and
adding a check for -1 apic does not make the code cleaner).

	Ingo 

