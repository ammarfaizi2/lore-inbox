Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbTIWS1v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 14:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263285AbTIWS1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 14:27:51 -0400
Received: from palrel11.hp.com ([156.153.255.246]:32394 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262241AbTIWS1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 14:27:18 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16240.36993.148535.613568@napali.hpl.hp.com>
Date: Tue, 23 Sep 2003 11:27:13 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>, davidm@hpl.hp.com,
       davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au, bcrl@kvack.org,
       ak@suse.de, iod00d@hp.com, peterc@gelato.unsw.edu.au,
       linux-ns83820@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
In-Reply-To: <20030923105712.552dbb1e.davem@redhat.com>
References: <BFF315B8E1D7F845B8FC1C28778693D70AFEC6@usslc-exch1.na.uis.unisys.com>
	<20030923105712.552dbb1e.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 23 Sep 2003 10:57:12 -0700, "David S. Miller" <davem@redhat.com> said:

  DaveM> On Tue, 23 Sep 2003 12:58:59 -0500
  DaveM> "Van Maren, Kevin" <kevin.vanmaren@unisys.com> wrote:

  >> Rate-limited unaligned loads in user space make a lot more sense, since
  >> they _may_ point out issues in the code.

  DaveM> That's what generates the bulk of the noise in people's ia64
  DaveM> dmesg output.

At the moment, there are two ways to control the unaligned message printing:

 - use the dmesg command to lower the printing threshold below KERN_WARNING
   ("dmesg -n4", IIRC)

 - use prctl --unalign=silent to turn off unaligned printing for a
   particular task and its children

If these mechanisms are not sufficient, there is nothing to stop
anyone from cooking up a patch.  For my puposes, what's there works
nicely so I myself have no plans to make changes in this area.

	--david
