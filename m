Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751671AbWISUK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbWISUK2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 16:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbWISUK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 16:10:28 -0400
Received: from tomts43.bellnexxia.net ([209.226.175.110]:46495 "EHLO
	tomts43-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751339AbWISUK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 16:10:27 -0400
Date: Tue, 19 Sep 2006 16:05:14 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: "S. P. Prasanna" <prasanna@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, Tom Zanussi <zanussi@us.ibm.com>,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       systemtap@sources.redhat.com, ltt-dev@shafik.org
Subject: Re: [PATCH] Linux Kernel Markers 0.2 for Linux 2.6.17
Message-ID: <20060919200514.GB9459@Krystal>
References: <20060919183447.GA16095@Krystal> <20060919083900.GE23836@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060919083900.GE23836@in.ibm.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 15:39:20 up 27 days, 16:48,  6 users,  load average: 0.51, 1.43, 1.03
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* S. P. Prasanna (prasanna@in.ibm.com) wrote:
> I think having so many config options is not a good idea, you can group them
> and reduce the number of config options.
> 

Then we would have to determine what the scenarios are. The problem is to cover
all interesting instrumentation mixes efficiently.

I think it could be a good enough list :

Fprobes only
Dynamic + Fprobes (supports dynamic probes and uses fprobes for non probable
                   code)
Dynamic only
Printk only

Which would be expressed in the following menu :

choice Marker behavior
  * Inactive
  * Dynamic probes
  * Function probes (Fprobes)
  * Dynamic probes complemented with Fprobes
  * Printk

if selected "Dynamic probes" or "Dynamic probes complemented with Fprobes"
  choice2 Dynamic probes behavior
    * Kprobes
    * Jprobes

Any thoughts ?

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
