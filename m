Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264358AbUGZGEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbUGZGEu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 02:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUGZGEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 02:04:50 -0400
Received: from fmr06.intel.com ([134.134.136.7]:17093 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S264358AbUGZGEs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 02:04:48 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] kernel events layer
Date: Sun, 25 Jul 2004 23:04:31 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A6EBFB0@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] kernel events layer
Thread-Index: AcRxPY6O377djQnRQ3KBPHXQPV8gzgAkTiJQ
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Chris Wedgwood" <cw@f00f.org>, "Robert Love" <rml@ximian.com>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Jul 2004 06:04:31.0697 (UTC) FILETIME=[6B005C10:01C472D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Chris Wedgwood
>
> This part worries me a lot.  I would alsmost rather all possible
> messages get stuck somewhere common so driver writes can't add these
> ad-hoc and we can avoid a proliferation of either similar or pointless
> messages.
> 
> Forcing these into a common place lets people eyeball if a new
> messages really is necessary --- and it makes writing applications to
> deal with these things easier (since you don't have to scan the entire
> kernel tree).

That sounds to me like the perfect job for grep. In fact, it is _very_
similar to the job the GNU guys did on the early days of i18n. They
had the tool that extracted all the strings in _("xlate me") 
[#define _(a) a ] and built a catalog.

If you guys are up to it, I volunteer to write/port such a tool to scan 
out the send_kevent{_atomic,}()s and make a catalog out of it.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
