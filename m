Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281309AbRKPLiS>; Fri, 16 Nov 2001 06:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281311AbRKPLiI>; Fri, 16 Nov 2001 06:38:08 -0500
Received: from h55p103-2.delphi.afb.lu.se ([130.235.187.175]:43157 "EHLO gin")
	by vger.kernel.org with ESMTP id <S281309AbRKPLh6>;
	Fri, 16 Nov 2001 06:37:58 -0500
Date: Fri, 16 Nov 2001 12:37:35 +0100
To: Nathan Myers <ncm@nospam.cantrip.org>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com, torvalds@transmeta.com
Subject: Re: [PATCH] omnibus include/ cleanup (biggish)
Message-ID: <20011116123735.B1804@h55p111.delphi.afb.lu.se>
In-Reply-To: <20011115175144.A6622@shell7.ba.best.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011115175144.A6622@shell7.ba.best.com>
User-Agent: Mutt/1.3.23i
From: andersg@0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 05:51:44PM -0800, Nathan Myers wrote:
> I have located every place under linux/include/ that #defines
> a macro with an improper unary expression, like any of

you missed this which generates a compiletime-error in sched.c with compiled
with WAITQUEUE_DEBUG

--- wait.h~	Thu Nov 15 22:54:50 2001
+++ wait.h	Thu Nov 15 22:59:04 2001
@@ -105,7 +105,7 @@
 	} while (0)
 #define WQ_CHECK_LIST_HEAD(list) 						\
 	do {									\
-		if (!list->next || !list->prev)					\
+		if (!(list)->next || !(list)->prev)					\
 			WQ_BUG();						\
 	} while(0)
 #define WQ_NOTE_WAKER(tsk)							\


-- 

//anders/g

