Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbTKQX5R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 18:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbTKQX5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 18:57:17 -0500
Received: from fmr05.intel.com ([134.134.136.6]:49855 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262139AbTKQX5Q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 18:57:16 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: format_cpumask()
Date: Mon, 17 Nov 2003 15:56:34 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0F37B8@scsmsx401.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: format_cpumask()
Thread-Index: AcOtY4pF1GaCZl8PQ9CsRwsKdKVrmAAAcFJQ
From: "Luck, Tony" <tony.luck@intel.com>
To: "William Lee Irwin III" <wli@holomorphy.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Nov 2003 23:56:38.0843 (UTC) FILETIME=[70DEE0B0:01C3AD66]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was trying to make it a NR_CPUS -bit integer with the 
> highest nybbles
> printed first. What's your favorite alternative?

The prettiest output format I can think of would be
to pretend that we had enough bits for NR_CPUS.  I.e.
on a 128 cpu system, cpu0 looks like:

 00000000000000000000000000000001

and cpu 127 is:

 80000000000000000000000000000000

This is probably the messiest to implement :-(

-Tony
