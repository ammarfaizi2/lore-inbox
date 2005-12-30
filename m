Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbVL3Ved@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbVL3Ved (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 16:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbVL3Ved
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 16:34:33 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:24819 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932080AbVL3Vec
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 16:34:32 -0500
Subject: Re: [PATCH] protect remove_proc_entry
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1135978110.6039.81.camel@localhost.localdomain>
References: <1135973075.6039.63.camel@localhost.localdomain>
	 <1135978110.6039.81.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 30 Dec 2005 13:34:26 -0800
Message-Id: <1135978466.32431.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 16:28 -0500, Steven Rostedt wrote:

> +	spin_lock_irqsave(&remove_proc_lock, flags);
...
> +	spin_unlock_irqrestore(&remove_proc_lock, flags);

Why do an irqsave here? Are you not sure what context it gets called
from?

Daniel

