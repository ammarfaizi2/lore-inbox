Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280878AbRKLRwT>; Mon, 12 Nov 2001 12:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280883AbRKLRwJ>; Mon, 12 Nov 2001 12:52:09 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:43508 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S280878AbRKLRv7>; Mon, 12 Nov 2001 12:51:59 -0500
Importance: Normal
Subject: Hardsector size support in 2.4 and 2.5
To: linux-kernel@vger.kernel.org
Cc: evms-devel@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF052859B1.127521A3-ON85256B02.00602D84@raleigh.ibm.com>
From: "Mark Peloquin" <peloquin@us.ibm.com>
Date: Mon, 12 Nov 2001 11:51:44 -0600
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.8 |June 18, 2001) at
 11/12/2001 12:51:35 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering if 2.5 will *really* support different hard sector
sizes. Today the hardsect array in the kernel seems to serve
little purpose. Drivers fill it in, but then what? It does not appear
to be used in any io path computations as illustrated by code
in submit_bh and generic_make_request which use a few
hardcoded shifts by 9 when dealing with sector sizes.

Is the hardsect array on the way *in* or the way *out* of the
kernel? Will 2.5 take the real hardsector value into account?
Or can we expect everything to be handled in 512 byte
multiples  (as we do today)?

Thanks.
Mark Peloquin

