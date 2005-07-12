Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVGLIrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVGLIrZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 04:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVGLIrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 04:47:16 -0400
Received: from ms003msg.fastwebnet.it ([213.140.2.42]:61430 "EHLO
	ms003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S261279AbVGLIpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 04:45:09 -0400
Date: Tue, 12 Jul 2005 10:43:45 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Philippe Troin <phil@fifi.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Lack of Documentation about SA_RESTART...
Message-ID: <20050712104345.05b1661c@localhost>
In-Reply-To: <87mzos4s6r.fsf@ceramic.fifi.org>
References: <20050711123237.787dfcde@localhost>
	<20050711143427.GC14529@thunk.org>
	<87mzos4s6r.fsf@ceramic.fifi.org>
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Jul 2005 20:30:20 -0700
Philippe Troin <phil@fifi.org> wrote:

> Except for select() and poll(), which should always return EINTR even
> when interrupted with a SA_RESTART signal.

SUSV3 says this for select():
"If SA_RESTART has been set for the interrupting signal, it is
implementation-defined whether the function restarts or returns with
[EINTR]"

and says nothing for poll()...

But it says nothing also for "pause()", for example... and I doubt that
it's supposed to be automatically restarted :)

-- 
	Paolo Ornati
	Linux 2.6.12.2 on x86_64
