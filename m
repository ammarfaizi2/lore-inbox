Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267397AbUI0WKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267397AbUI0WKo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 18:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267401AbUI0WKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 18:10:44 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:18979 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S267397AbUI0WKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 18:10:42 -0400
To: Paul Jackson <pj@sgi.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <1096302710971@topspin.com> <10963027102899@topspin.com>
	<20040927131014.695b8212.pj@sgi.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 27 Sep 2004 15:10:41 -0700
In-Reply-To: <20040927131014.695b8212.pj@sgi.com> (Paul Jackson's message of
 "Mon, 27 Sep 2004 13:10:14 -0700")
Message-ID: <52fz53e526.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH][1/2] [RESEND] kobject: add HOTPLUG_ENV_VAR
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 27 Sep 2004 22:10:41.0611 (UTC) FILETIME=[D3C981B0:01C4A4DE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Paul> Would a procedure (not inlined) save text space here,
    Paul> provide better type checking, and be easier to read?

The problem is that the straightforward way to implement this helper
modifies three of its parameters (the current buffer location, the
amount of space left, and the current index).  It seemed ugly to force
these three parameters to be passed by address.

I could easily rework this to do as you suggest though.  Greg, what's
your opinion?

Thanks,
  Roland
