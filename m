Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUKBPcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUKBPcG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 10:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbUKBPaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 10:30:19 -0500
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:61021 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261559AbUKBPZE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 10:25:04 -0500
Subject: Re: [PATCH 2.4] usb serial write fix
From: Paul Fulghum <paulkf@microgate.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1099404208.2856.25.camel@deimos.microgate.com>
References: <mailman.1099321382.10097.linux-kernel2news@redhat.com>
	 <20041101193616.2d517e77@lembas.zaitcev.lan>
	 <1099404208.2856.25.camel@deimos.microgate.com>
Content-Type: text/plain
Message-Id: <1099409108.2856.35.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 02 Nov 2004 09:25:08 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-02 at 08:03, Paul Fulghum wrote:
> On Mon, 2004-11-01 at 21:36, Pete Zaitcev wrote:
> > Why testing for signals? Do you expect any?
> 
> post_helper can run in a user process as well
> as keventd. The user process can get a signal
> like HUP to pppd.

This brings up a question.

post_helper is using a single list to queue
write requests from all user processes.

A write request on the list can be processed
in a user process different than the submitting process.

Signals sent to one user process can interfere with
the processing of write requests from a different process.

Is this not a security problem?

-- 
Paul Fulghum
paulkf@microgate.com

