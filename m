Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423672AbWJZVQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423672AbWJZVQW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 17:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423677AbWJZVQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 17:16:22 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:7145 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1423672AbWJZVQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 17:16:21 -0400
Date: Thu, 26 Oct 2006 14:14:50 -0700
From: Paul Jackson <pj@sgi.com>
To: ego@in.ibm.com
Cc: rusty@rustcorp.com.au, torvalds@osdl.org, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, vatsa@in.ibm.com,
       dipankar@in.ibm.com, gaughen@us.ibm.com, arjan@linux.intel.org,
       davej@redhat.com, venkatesh.pallipadi@intel.com, kiran@scalex86.org
Subject: Re: [PATCH 4/5] lock_cpu_hotplug: Redesign - Lightweight
 implementation of lock_cpu_hotplug.
Message-Id: <20061026141450.53b48b88.pj@sgi.com>
In-Reply-To: <20061026105731.GE11803@in.ibm.com>
References: <20061026104858.GA11803@in.ibm.com>
	<20061026105058.GB11803@in.ibm.com>
	<20061026105342.GC11803@in.ibm.com>
	<20061026105523.GD11803@in.ibm.com>
	<20061026105731.GE11803@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gautham wrote:
+ *- Readers assume control iff:					*
+ *    a) No other reader has a reference and no writer is writing.	*
+ *    OR								*
+ *    b) Atleast one reader (on *any* cpu) has a reference.		*

Isn't this logically equivalent to stating:

  *- Readers assume control iff no writer is writing

(Or if it's not equivalent, it might be interesting to state why.)

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
