Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266488AbSKGLeP>; Thu, 7 Nov 2002 06:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266491AbSKGLeP>; Thu, 7 Nov 2002 06:34:15 -0500
Received: from holomorphy.com ([66.224.33.161]:10916 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266488AbSKGLeO>;
	Thu, 7 Nov 2002 06:34:14 -0500
Date: Thu, 7 Nov 2002 03:38:42 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Andrew Morton <akpm@digeo.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: get_user_pages rewrite (completed, updated for 2.4.46)
Message-ID: <20021107113842.GB23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	Andrew Morton <akpm@digeo.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <20021107110840.P659@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021107110840.P659@nightmaster.csn.tu-chemnitz.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 11:08:40AM +0100, Ingo Oeser wrote:
+#ifdef OBSOLETE_PAGE_WALKER
+	if (vmas) {
+		gup_u.pv.vmas = vmas;
+		gup_u.pv.max_vmas = len;
+		walker = gup_add_pv;
+		printk("Obsolete argument \"vmas\" used!"
+		       " Please send this report to linux-mm@vger.kernel.org"
+		       " or fix the caller. Stack trace follows...\n");
+		WARN_ON(vmas);
+	}
+#else
+	/* FIXME: Or should we simply ignore it? -ioe */
+	BUG_ON(vmas);
+#endif

What on earth? Why not just remove the obsolete code?


Bill
