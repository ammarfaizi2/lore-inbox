Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264306AbUEMREI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264306AbUEMREI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 13:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264309AbUEMREI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 13:04:08 -0400
Received: from [66.35.79.110] ([66.35.79.110]:30956 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S264306AbUEMREF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 13:04:05 -0400
Date: Thu, 13 May 2004 10:03:58 -0700
From: Tim Hockin <thockin@hockin.org>
To: Colin Paton <colin.paton@etvinteractive.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Natsemi ethernet 'cable magic' fix can cause problems
Message-ID: <20040513170358.GA19426@hockin.org>
References: <1084444503.4548.141.camel@colinp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084444503.4548.141.camel@colinp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 11:35:03AM +0100, Colin Paton wrote:
> The problem was strange - about 30% packet loss was experienced during
> pings. Moving the box to a different ethernet wall outlet (but still
> using the same port on the switch) cured the problem. The problem
> therefore appeared to be cable dependant.
> 
> It would appear that the call to 'do_cable_magic()' in
> drivers/net/natsemi.c causes the problem to occur.
> 
> It looks as though this was added in to actually *fix* such problems...
> but in our case it made things worse.

I'm the responsible party on that one.  do_cable_magic() was a direct
result of a significant amount of work with National's engineers to
root-cause some major problems we had had.

If I recall, the problem we experienced was when the cable was "short"
(where short was < 30m, I think).  What can you tell me about your cabling
setup?

Willing to test?  Ping me back.
