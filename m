Return-Path: <linux-kernel-owner+w=401wt.eu-S1161281AbXAHNAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161281AbXAHNAm (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 08:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161282AbXAHNAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 08:00:42 -0500
Received: from homer.mvista.com ([63.81.120.158]:53221 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1161281AbXAHNAm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 08:00:42 -0500
Subject: Re: [PATCH -rt] scheduling while atomic in remove_proc_entry()
From: Daniel Walker <dwalker@mvista.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <1168258802.6235.18.camel@twins>
References: <20061229211237.690413000@mvista.com>
	 <1168258802.6235.18.camel@twins>
Content-Type: text/plain
Date: Mon, 08 Jan 2007 04:59:37 -0800
Message-Id: <1168261177.26086.284.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-08 at 13:20 +0100, Peter Zijlstra wrote:

> 
> Well, no. Draining after the inspect 'all' loop doesn't make sense, but
> looking at 2.6.20-rc3-rt0 remove_proc_entry() looks sane.

When it was inside the loop it drained every iteration . So it made more
sense to put it after the loop. But I don't have a clue what the drain
is doing (might be good to add liberal comments, if you haven't
already).

Daniel

