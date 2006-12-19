Return-Path: <linux-kernel-owner+w=401wt.eu-S932480AbWLSOhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbWLSOhT (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 09:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWLSOhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 09:37:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39202 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932506AbWLSOhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 09:37:17 -0500
Date: Tue, 19 Dec 2006 09:36:06 -0500
From: Dave Jones <davej@redhat.com>
To: "J.H." <warthog9@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>, Matti Aarnio <matti.aarnio@zmailer.org>,
       Randy Dunlap <randy.dunlap@oracle.com>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       hpa@zytor.com, webmaster@kernel.org
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
Message-ID: <20061219143606.GE25461@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"J.H." <warthog9@kernel.org>, Willy Tarreau <w@1wt.eu>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>, hpa@zytor.com,
	webmaster@kernel.org
References: <20061214223718.GA3816@elf.ucw.cz> <20061216094421.416a271e.randy.dunlap@oracle.com> <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain> <45858B3A.5050804@oracle.com> <20061217223730.GW10054@mea-ext.zmailer.org> <1166402576.26330.81.camel@localhost.localdomain> <20061219064646.GJ24090@1wt.eu> <1166513991.26330.136.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166513991.26330.136.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 11:39:51PM -0800, J.H. wrote:

 > I'll have to look into it - but by and large the round robining tends to
 > work.  Specifically as I am writing this the machines are both pushing
 > right around 150mbps, however the load on zeus1 is 170 vs. zeus2's 4.
 > Also when we peak the bandwidth we do use every last kb we can get our
 > hands on, so doing any tunneling takes just that much bandwidth away
 > from the total.
 > 
 > 	Number of Processes running
 > process		#1	#2
 > ------------------------------------
 > rsync		162	69
 > http		734	642
 > ftp		353	190

A wild idea just occured to me.  You guys are running Fedora/RHEL kernels
on the kernel.org boxes iirc, which have Ingo's 'tux' httpd accelerator.
It might not make the problem go away, but it could make it more
bearable under high load.   Or it might do absolutely squat depending
on the ratio of static/dynamic content.

		Dave

-- 
http://www.codemonkey.org.uk
