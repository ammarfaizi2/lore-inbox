Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755835AbWKQTna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755835AbWKQTna (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 14:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755839AbWKQTn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 14:43:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59575 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1755835AbWKQTn3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 14:43:29 -0500
Date: Fri, 17 Nov 2006 19:43:03 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com
Subject: Re: 2.6.19-rc6 -- dm: possible recursive locking detected
Message-ID: <20061117194303.GB4409@agk.surrey.redhat.com>
Mail-Followup-To: Heiko Carstens <heiko.carstens@de.ibm.com>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	dm-devel@redhat.com
References: <20061117153003.GB7131@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117153003.GB7131@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 04:30:03PM +0100, Heiko Carstens wrote:
> =============================================
> [ INFO: possible recursive locking detected ]
> 2.6.19-rc6-g1b9bb3c1 #28
> ---------------------------------------------
> kpartx/945 is trying to acquire lock:
>  (&md->io_lock){----}, at: [<00000000001f8faa>] dm_request+0x42/0x24c
> 
> but task is already holding lock:
>  (&md->io_lock){----}, at: [<00000000001f8faa>] dm_request+0x42/0x24c
 
Known problem - nobody's written a patch to fix it yet to my knowledge,
but I don't recall any reports of real world lock-ups related to this - just
several reports of the debug warning messages:-)

Simply ignore the message for now - or submit a patch that fixes the
underlying problem:-)

Alasdair
-- 
agk@redhat.com
