Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312886AbSDFXlC>; Sat, 6 Apr 2002 18:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312889AbSDFXlB>; Sat, 6 Apr 2002 18:41:01 -0500
Received: from zero.tech9.net ([209.61.188.187]:6151 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S312886AbSDFXlA>;
	Sat, 6 Apr 2002 18:41:00 -0500
Subject: Re: [CFT][RFC][PATCH][CLEANUP] task->state cleanup: pilot
From: Robert Love <rml@tech9.net>
To: Paul P Komkoff Jr <i@stingr.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020406220612.GF839@stingr.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 06 Apr 2002 18:41:01 -0500
Message-Id: <1018136462.899.119.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-04-06 at 17:06, Paul P Komkoff Jr wrote:
> This is the pilot of task->state cleanup in 2.4.x. Feel free to blame me for
> incorrect use of set_task_state vs. __set_task_state

Nice cleanup.  Awful lot of [items] in the subject though :)

You don't have to worry about your choices wrt set_current_state vs
__set_current_state - by using only set_current_state you erred on the
side of caution.  set_current_state enforces a memory barrier around the
write on SMP (on UP it is the same code) while __set_current_state does
not.

If anyone can verify where it is safe in this code to use
__set_current_state instead, speak up so Paul can make the micro
optimization accordingly.

	Robert Love

