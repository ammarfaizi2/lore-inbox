Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264933AbVBEG5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbVBEG5e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 01:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264887AbVBEG5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 01:57:33 -0500
Received: from colin2.muc.de ([193.149.48.15]:9482 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264933AbVBEG5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 01:57:24 -0500
Date: 5 Feb 2005 07:57:22 +0100
Date: Sat, 5 Feb 2005 07:57:22 +0100
From: Andi Kleen <ak@muc.de>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>,
       karim@opersys.com
Subject: Re: [PATCH] relayfs redux, part 3
Message-ID: <20050205065722.GA52309@muc.de>
References: <16899.55393.651042.627079@tut.ibm.com> <20050204221230.GA97506@muc.de> <16899.62896.559319.678176@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16899.62896.559319.678176@tut.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The main reason would be that length would be 0 only if the buffers
> were full, so the caller can suspend writing if it sees that, until
> e.g. a daemon catches up.

Would be? Is there actually any caller doing this? 

Better eliminate it and if someone really does it add a separate function
that checks this condition.

-Andi
