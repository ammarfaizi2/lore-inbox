Return-Path: <linux-kernel-owner+w=401wt.eu-S1755002AbXACJKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755002AbXACJKq (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 04:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755024AbXACJKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 04:10:45 -0500
Received: from neopsis.com ([213.239.204.14]:45712 "EHLO
	matterhorn.dbservice.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755002AbXACJKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 04:10:44 -0500
Message-ID: <459B7766.5050404@dbservice.com>
Date: Wed, 03 Jan 2007 10:29:10 +0100
From: Tomas Carnecky <tom@dbservice.com>
User-Agent: Thunderbird 2.0b1 (X11/20061212)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
CC: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       akpm@osdl.org
Subject: Re: [PATCH] 3/4 qrcu: add documentation
References: <11678105083001-git-send-email-jens.axboe@oracle.com> <20070103083123.GJ11203@kernel.dk>
In-Reply-To: <20070103083123.GJ11203@kernel.dk>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Neopsis MailScanner using ClamAV and Spaassassin
X-Neopsis-MailScanner: Found to be clean
X-Neopsis-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.247,
	required 5, autolearn=spam, AWL 0.13, BAYES_00 -2.60,
	FORGED_RCVD_HELO 0.14, SARE_SUB_ODDWORD_Q 0.09)
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> diff --git a/Documentation/RCU/checklist.txt b/Documentation/RCU/checklist.txt
> index f4dffad..36d6185 100644
> --- a/Documentation/RCU/checklist.txt
> +++ b/Documentation/RCU/checklist.txt
> @@ -259,3 +259,16 @@ over a rather long period of time, but improvements are always welcome!
>  
>  	Note that, rcu_assign_pointer() and rcu_dereference() relate to
>  	SRCU just as they do to other forms of RCU.
> +
> +14.	QRCU is very similar to SRCU, but features very fast grace-period
> +	processing at the expense of heavier-weight read-side operations.
> +	The correspondance between QRCU and SRCU is as follows:
> +
> +		QRCU			SRCU
> +
> +		struct qrcu_struct	struct srcu_struct
> +		init_qrcu_struct()	init_srcu_struct()
> +		cleanup_qrcu_struct()	cleanup_srcu_struct()
> +		qrcu_read_lock()	srcu_read_lock()
> +		qrcu_read-unlock()	srcu_read_unlock()

A small typo: qrcu_read_unlock()

tom
