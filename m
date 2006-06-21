Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWFUAOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWFUAOx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 20:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWFUAOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 20:14:52 -0400
Received: from gw.goop.org ([64.81.55.164]:22401 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750825AbWFUAOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 20:14:52 -0400
Message-ID: <44988F7F.2010502@goop.org>
Date: Tue, 20 Jun 2006 17:14:55 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Christian.Limpach@cl.cam.ac.uk, chrisw@sous-sol.org
Subject: Re: [PATCH] Implement kasprintf
References: <44988B5C.9080400@goop.org> <20060620171020.301add23.rdunlap@xenotime.net>
In-Reply-To: <20060620171020.301add23.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> Why do we want a separate source file for this one function?
>   
Because if it shared a file with something else, someone would complain 
about it bloating code which doesn't use it...  At the moment there are 
no in-tree users (though I'm sure there's something out there with an 
open-coded version of this), but we'll be needing it for Xen.

I'm happy to fold it into vsprintf.c though.

    J
