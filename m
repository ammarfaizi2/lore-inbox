Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262757AbUCPESL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 23:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbUCPESL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 23:18:11 -0500
Received: from fmr03.intel.com ([143.183.121.5]:45202 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S262757AbUCPESK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 23:18:10 -0500
Message-Id: <200403160417.i2G4Hsm01819@unix-os.sc.intel.com>
From: "Kenneth Chen" <kenneth.w.chen@intel.com>
To: "'Anton Blanchard'" <anton@samba.org>, "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Patch - make config_max_raw_devices work
Date: Mon, 15 Mar 2004 20:17:54 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQLAKQjOXUvTLdcThuyXcf353CpSAAC72vA
In-Reply-To: <20040316023946.GO19737@krispykreme>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard on Mon, March 15, 2004 6:40 PM
> > Badari wrote basically the same patch a couple of months back.  I dropped
> > it then, too ;)
> >
> > raw is a deprecated interface and if we keep on adding new features to it,
> > we will never be rid of the thing.  If your application requires more than
> > 256 raw devices, please convert it to open the block device directly,
> > passing in the O_DIRECT flag.
>
> We only deprecated this thing on the 4th Feb 2004. I want to see the raw
> driver die but we cant expect apps to change their interfaces in the space
> of a month.
>
> Can we reach a compromise? :)

I second that with Anton.  It takes awhile for application to convert to
O_DIRECT.  We are already educating OSV to convert that.  At mean time, this
is required for legacy application used in production environment (legacy in
The sense that went in production a couple month ago).

- Ken


