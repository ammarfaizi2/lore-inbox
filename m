Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272913AbRIPWq7>; Sun, 16 Sep 2001 18:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272898AbRIPWqu>; Sun, 16 Sep 2001 18:46:50 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:22745 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S272913AbRIPWqj>;
	Sun, 16 Sep 2001 18:46:39 -0400
Date: Sun, 16 Sep 2001 23:47:00 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>, Andreas Steinmetz <ast@domdv.de>
Cc: linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: broken VM in 2.4.10-pre9
Message-ID: <180945403.1000684019@[169.254.62.211]>
In-Reply-To: <Pine.LNX.4.33.0109161415340.22182-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0109161415340.22182-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



--On Sunday, 16 September, 2001 2:28 PM -0700 Linus Torvalds 
<torvalds@transmeta.com> wrote:

>  - age a non-referenced page on a list: move to "next" list downwards (ie
>    free if already inactive, move to inactive if currently active)

Do you still make the distinction between Inactive Clean
and Inactive Dirty (& just move to appropriate list)?

Effectively this is just a 'binary' aging function (OK position
on the list matters too). Others on the list have observed
page->age performs in a binary manner anyhow with exponential
aging.

How do you balance between Inactive Clean before Inactive Dirty
and avoid evicting many (infrequently used) code pages at
the expense of many (historic, even less frequently used) dirty
data pages? Or don't we care?

--
Alex Bligh
