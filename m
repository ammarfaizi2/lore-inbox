Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbVLCMGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbVLCMGK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 07:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVLCMGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 07:06:09 -0500
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:21656 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751184AbVLCMGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 07:06:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=4XDdtWqMOBZCG/1zVzpUUJR+ve48tWTnF8WLg4f+Nc+ljJjW4EzGRYVXzIMZNONm7S+jjLaxgdkqHOzCjkYMvLItuwfF3A66HI6dLg7+qpZBOOfgmEGnrwKokL8nN6tObW8KHA7nXn9o7VuldHYV8eTFPaJ8ugFPrll8ISRdxLo=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Hugh Dickins <hugh@veritas.com>
Subject: Sorry (was: Re: [2.6.15-rc1+ regression] do_file_page bug introduced in recent rework)
Date: Sat, 3 Dec 2005 13:06:07 +0100
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       linux-mm@vger.kernel.org
References: <200512020111.56671.blaisorblade@yahoo.it> <Pine.LNX.4.61.0512031000360.8984@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0512031000360.8984@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512031306.07705.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 December 2005 11:03, Hugh Dickins wrote:
> On Fri, 2 Dec 2005, Blaisorblade wrote:

> > Indeed, the condition to test (and to possibly BUG_ON/pte_ERROR) is that
> > ->populate must exist for the sys_remap_file_pages call to work.
>
> I'm puzzled.

Don't worry, you're right.

> Both filemap_populate and shmem_populate 
> now test VM_NONLINEAR before calling install_file_pte.

Uff, sorry, you're right - I hadn't seen this change (not mentioned in the 
Changelog, and I'm in shortness of time currently).

I haven't had the time to look even at the whole commit I referred to... (this 
summer I had studied the code for a whole month!).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
