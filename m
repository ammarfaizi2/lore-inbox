Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbUDDHMR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 03:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbUDDHMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 03:12:17 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:20178 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262236AbUDDHMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 03:12:14 -0400
Date: Sat, 3 Apr 2004 23:11:42 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: remove bitmap_shift_*() bitmap length limits
Message-Id: <20040403231142.6fe48744.pj@sgi.com>
In-Reply-To: <20040401144234.2ef3c205.pj@sgi.com>
References: <20040330065152.GJ791@holomorphy.com>
	<20040330073604.GK791@holomorphy.com>
	<20040330081142.GL791@holomorphy.com>
	<20040401133033.435a3857.pj@sgi.com>
	<20040401144234.2ef3c205.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hah - save another 16 bytes of kernel text size, by marking _setbitval
and _getbitval "inline".  Apparently their function call overhead was
slightly bigger than their guts, so it's cheaper to have two copies of
each.  Faster too, I presume.  Not that that's the primary concern.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
