Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271933AbTHROam (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 10:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271938AbTHROal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 10:30:41 -0400
Received: from holomorphy.com ([66.224.33.161]:21734 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S271933AbTHROae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 10:30:34 -0400
Date: Mon, 18 Aug 2003 07:31:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Michael Frank <mhf@linuxmail.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dumb question: Why are exceptions such as SIGSEGV not logged
Message-ID: <20030818143146.GV32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Michael Frank <mhf@linuxmail.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200308170410.30844.mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308170410.30844.mhf@linuxmail.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 17, 2003 at 04:10:30AM +0800, Michael Frank wrote:
> Linux logs almost everything, why not exceptions such as SIGSEGV in
> userspace which may be very informative?

Such exceptions are part of the normal operation of certain kinds of
programs, such as ones using (nowadays unusual) certain garbage
collection algorithms. I actually installed such a beast (Lisp system)
in no small part so it would exercise "invalid" memory accesses and
test various bits of VM code related to such. For other VM people
interested in it, there's an sbcl debian package that recompiles a
moderately sized chunk of Lisp code and hence runs the system at
install-time, and so exercises the SIGSEGV path rather heavily on
32-bit systems and/or systems with <= 2GB of RAM. No particular
intervention apart from (re)installing it is required to pound the
SIGSEGV path like a wild monkey, so it's actually a very convenient
touch test for such things.


-- wli
