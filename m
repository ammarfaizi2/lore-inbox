Return-Path: <linux-kernel-owner+w=401wt.eu-S936677AbWLKPkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936677AbWLKPkc (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 10:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936661AbWLKPkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 10:40:31 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:39586 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936649AbWLKPkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 10:40:31 -0500
Subject: Re: [PATCH -rt][RESEND] spin lock imbalance in ibm emac
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061211092759.GA23041@elte.hu>
References: <20061210163848.101585000@mvista.com>
	 <20061211092759.GA23041@elte.hu>
Content-Type: text/plain
Date: Mon, 11 Dec 2006 07:40:24 -0800
Message-Id: <1165851624.7764.3.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-11 at 10:27 +0100, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > Sent this a long time ago, still exists. 
> > 
> > Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> 
> hm, what does this do, and why isnt it upstream?


AFAIK, those locks are added in -rt . I'm not sure how they got in
there, but they fix that driver when running in a thread. The driver has
unsafe SMP locking, but the only system it runs on (PPC4xx) is
uniprocessor. So it's not broken upstream per se.

Dainel

