Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264385AbUFCPYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264385AbUFCPYW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 11:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbUFCPYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 11:24:19 -0400
Received: from mta10-svc.ntlworld.com ([62.253.162.94]:55879 "EHLO
	mta10-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S265515AbUFCPLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 11:11:04 -0400
Date: Thu, 3 Jun 2004 16:10:59 +0100
From: Mike Jagdis <mjagdis@eris-associates.co.uk>
To: khandelw@cs.fsu.edu
Cc: jyotiraditya@softhome.net, linux-kernel@vger.kernel.org
Subject: Re: Select/Poll
Message-ID: <20040603151058.GA3169@eris-associates.co.uk>
References: <courier.40BD66BD.00006D7D@softhome.net> <1086190109.a0ea5ca71914e@system.cs.fsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086190109.a0ea5ca71914e@system.cs.fsu.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 11:28:29AM -0400, khandelw@cs.fsu.edu wrote:
> Hello,
>    Can you give more details - Like which machine which vendor etc.,
> On a sony vaio pcg frv31 laptop/ redhat 9.0/ after firing some 36,000+ request
> my select multiplexed server used to fail. With select I believe you not get
> any packet loss...

Then you'd be wrong. Poll/select tell you when desriptors
are readable/writable. They do *not* impose any magic queuing
mechanism that guarantees the buffers won't overflow. If the
low level protocol is non-flow controlled like UDP you *have*
to read data faster than it arrives and not write data faster
than it is being transmitted.

Mike

-- 
Mike Jagdis                        Web: http://www.eris-associates.co.uk
Eris Associates Limited            Tel: +44 7780 608 368
Reading, England                   Fax: +44 118 926 6974
