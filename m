Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318761AbSHBJQc>; Fri, 2 Aug 2002 05:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318767AbSHBJQc>; Fri, 2 Aug 2002 05:16:32 -0400
Received: from pizda.ninka.net ([216.101.162.242]:62626 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318761AbSHBJQc>;
	Fri, 2 Aug 2002 05:16:32 -0400
Date: Fri, 02 Aug 2002 02:06:53 -0700 (PDT)
Message-Id: <20020802.020653.105601161.davem@redhat.com>
To: ryan@completely.kicks-ass.org
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, gh@us.ibm.com,
       riel@conectiva.com.br, akpm@zip.com.au, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, rohit.seth@intel.com, sunil.saxena@intel.com,
       asit.k.mallick@intel.com
Subject: Re: large page patch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200208020205.47308.ryan@completely.kicks-ass.org>
References: <15690.9727.831144.67179@napali.hpl.hp.com>
	<20020802.012040.105531210.davem@redhat.com>
	<200208020205.47308.ryan@completely.kicks-ass.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ryan Cumming <ryan@completely.kicks-ass.org>
   Date: Fri, 2 Aug 2002 02:05:43 -0700
   
   What about applications that want fine-grained page aging? 4MB is a
   tad on the course side for most desktop applications.

Once vmscan sees the page and tries to liberate it, then it
will be unlarge'd and thus you'll get fine-grained page aging.

That's the beauty of my implementation suggestion.
