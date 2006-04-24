Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWDXHKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWDXHKZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 03:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWDXHKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 03:10:25 -0400
Received: from thunk.org ([69.25.196.29]:46821 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750958AbWDXHKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 03:10:25 -0400
Date: Mon, 24 Apr 2006 03:10:21 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Al Boldi <a1426z@gawab.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] threads_max: Simple lockout prevention patch
Message-ID: <20060424071021.GB14720@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Al Boldi <a1426z@gawab.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <200511142327.18510.a1426z@gawab.com> <200601301621.11463.a1426z@gawab.com> <200604240756.42483.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604240756.42483.a1426z@gawab.com>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 07:56:42AM +0300, Al Boldi wrote:
> 
> Simple attempt to provide a backdoor in a process lockout situation.
> 
> echo $$ > /proc/sys/kernel/su-pid allows pid to exceed the threads_max limit.

Why not just have the root process do:

echo {larger number} > /proc/sys/kernel/nr-threads

instead?  

						- Ted
