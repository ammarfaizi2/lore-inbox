Return-Path: <linux-kernel-owner+w=401wt.eu-S932312AbXAISBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbXAISBI (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 13:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbXAISBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 13:01:08 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:65009 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932312AbXAISBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 13:01:07 -0500
Subject: Re: [PATCH 2.6.20-rc4 1/4] futex priority based wakeup
From: Daniel Walker <dwalker@mvista.com>
To: Pierre Peiffer <pierre.peiffer@bull.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Dinakar Guniguntala <dino@in.ibm.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Ingo Molnar <mingo@elte.hu>, Ulrich Drepper <drepper@redhat.com>,
       Jakub Jelinek <jakub@redhat.com>, Darren Hart <dvhltc@us.ibm.com>,
       =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
In-Reply-To: <45A3BFC8.1030104@bull.net>
References: <45A3B330.9000104@bull.net>  <45A3BFC8.1030104@bull.net>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 09:59:57 -0800
Message-Id: <1168365598.26086.313.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-09 at 17:16 +0100, Pierre Peiffer wrote:
> @@ -133,8 +133,8 @@ struct futex_q {
>    * Split the global futex_lock into every hash list lock.
>    */
>   struct futex_hash_bucket {
> -       spinlock_t              lock;
> -       struct list_head       chain;
> +	spinlock_t              lock;
> +	struct plist_head       chain;

Should have tabs between spinlock_t and lock , and plist_head and
chain.. It looks like the original didn't, but as long as your cleaning
up may as well get add them.

Daniel



