Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbWCNVQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbWCNVQA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 16:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWCNVQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 16:16:00 -0500
Received: from fmr18.intel.com ([134.134.136.17]:13752 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932470AbWCNVP7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 16:15:59 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: Exports for hrtimer APIs
Date: Tue, 14 Mar 2006 13:15:52 -0800
Message-ID: <CBDB88BFD06F7F408399DBCF8776B3DC06A92A64@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Exports for hrtimer APIs
Thread-Index: AcZHfFylKEpn3Q3fQ1qc5dNOrYasUAALqpqg
From: "Stone, Joshua I" <joshua.i.stone@intel.com>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: "LKML" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Mar 2006 21:15:53.0561 (UTC) FILETIME=[7A21A490:01C647AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> NACK.  We only add exports when they are a) sensible and b) are used
> in kernel.

It seems to me that SystemTap does present a sensible need to have
these exports.

> If you guys want to keep your code out of tree that's your problem.

I'm not sure what else you would suggest for this usage model.
SystemTap dynamically generates modules based on user scripts, so
this isn't something that can be added to the tree.

If SystemTap is to be able to make use of hrtimers, the only alternative
I see is to create our own APIs in the tree that wrap hrtimer, and then
export those.  This seems much less sensible than just exporting what is
already there...


Josh
