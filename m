Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130006AbRA2AST>; Sun, 28 Jan 2001 19:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144574AbRA2ASJ>; Sun, 28 Jan 2001 19:18:09 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:42034 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S144550AbRA2ASA>; Sun, 28 Jan 2001 19:18:00 -0500
Message-ID: <3A74B6AE.C179050B@linux.com>
Date: Mon, 29 Jan 2001 00:17:50 +0000
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: D state after applying ps hang patch
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel 2.4.0-ac12

# ps -eo user,pid,args,wchan|egrep "imap|update|procmail"
root         7 [kupdate]        get_request_wait
david      627 imapd            get_request_wait
david      752 procmail -f linu down
david      761 procmail -f linu down
david      799 procmail -f linu down
david      854 procmail -f linu down
david      886 procmail -f linu down
david      847 imapd            get_request_wait
david     1079 procmail -f linu down
david     3280 imapd            interruptible_sleep_on_locked
david     3321 imapd            interruptible_sleep_on_locked

and the cpu load is artificially inflated to 9.17

-d

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
