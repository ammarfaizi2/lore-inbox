Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbVGSWIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbVGSWIo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 18:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbVGSWF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 18:05:59 -0400
Received: from mx1.elte.hu ([157.181.1.137]:35498 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261721AbVGSWE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 18:04:58 -0400
Date: Wed, 20 Jul 2005 00:04:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Stuart Hayes <Stuart_Hayes@dell.com>
Cc: ak@suse.de, riel@redhat.com, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: page allocation/attributes question (i386/x86_64 specific)
Message-ID: <20050719220403.GB3558@elte.hu>
References: <20050719212046.GB12089@humbolt.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050719212046.GB12089@humbolt.us.dell.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


there's one problem with the patch: it breaks things that need the low 
1MB executable (e.g. APM bios32 calls). It would at a minimum be needed 
to exclude the BIOS area in 0xd0000-0xfffff.

	Ingo
