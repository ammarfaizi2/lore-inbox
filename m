Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263422AbTETBCy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 21:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263432AbTETBCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 21:02:53 -0400
Received: from holomorphy.com ([66.224.33.161]:50922 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263422AbTETBCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 21:02:52 -0400
Date: Mon, 19 May 2003 18:15:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dan Kegel <dank@kegel.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       John Myers <jgmyers@netscape.com>, linux-aio@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Comparing the aio and epoll event frameworks.
Message-ID: <20030520011541.GR2444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dan Kegel <dank@kegel.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	John Myers <jgmyers@netscape.com>, linux-aio@kvack.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200305192333.QAA12018@pagarcia.nscp.aoltw.net> <Pine.LNX.4.55.0305191657540.6565@bigblue.dev.mcafeelabs.com> <3EC9807D.3080804@kegel.com> <Pine.LNX.4.55.0305191743230.6565@bigblue.dev.mcafeelabs.com> <20030520010258.GQ2444@holomorphy.com> <3EC986ED.80604@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC986ED.80604@kegel.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> I think this would be useful for network daemons that would like to
>> fairly schedule responses (i.e. not re-arm until a client on a given fd
>> deserves a turn again). IRC daemons would appear to be a perfect
>> candidate for such.  ...

On Mon, May 19, 2003 at 06:37:49PM -0700, Dan Kegel wrote:
> No need.  The plain old edge triggered behavior can handle this
> nicely.

AIUI after the iospace on an fd is exhausted the event will be re-armed.
It could probably be taken and then ignored until the client deserves a
response again. Is that what you had in mind?

(Don't take this too far; I'm in hypothetical land and am not pushing for
the feature hard if at all.)


-- wli
