Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbWIGSVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWIGSVS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 14:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbWIGSVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 14:21:18 -0400
Received: from code.and.org ([65.172.155.230]:9879 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id S1751023AbWIGSVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 14:21:16 -0400
To: David Madore <david.madore@ens.fr>
Cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
From: James Antill <james@and.org>
References: <20060905212643.GA13613@clipper.ens.fr>
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 07 Sep 2006 14:21:15 -0400
In-Reply-To: <20060905212643.GA13613@clipper.ens.fr> (David Madore's message of "Tue, 5 Sep 2006 23:26:43 +0200")
Message-ID: <m3r6yn4jxg.fsf@code.and.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: james@mail.and.org
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
X-SA-Exim-Version: 4.2 (built Tue, 02 May 2006 07:36:10 -0400)
X-SA-Exim-Scanned: Yes (on mail.and.org)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Madore <david.madore@ens.fr> writes:

> Hi.
>
> As we all know, capabilities under Linux are currently crippled to the
> point of being useless.  Attached is a patch (against 2.6.18-rc6)
> which attempts to make them work in a reasonably useful way and at the
> same time not break anything.  On top of the "additional" capabilities
> that lead up to root, it also adds "regular" capabilities which all
> processes have by default and which can be removed from specifically
> untrusted programs.

 Just a minor comment, can you break out the OPEN into at least
OPEN_R, OPEN_NONFILE_W and OPEN_W (possibly OPEN_A, but I don't want
that personally).
 The case I'm thinking about are network daemons that need to
open+write to the syslog socket but only have read access elsewhere.


 Also there is much more than just bind9 using capabilities, the
obvious ones that come to mind are NOATIME and AUDIT.

-- 
James Antill -- james@and.org
http://www.and.org/and-httpd
