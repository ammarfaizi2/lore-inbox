Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbULLVze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbULLVze (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 16:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbULLVze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 16:55:34 -0500
Received: from reserv6.univ-lille1.fr ([193.49.225.20]:15327 "EHLO
	reserv6.univ-lille1.fr") by vger.kernel.org with ESMTP
	id S262142AbULLVz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 16:55:26 -0500
Message-ID: <41BCBE07.8080509@tremplin-utc.net>
Date: Sun, 12 Dec 2004 22:54:15 +0100
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Nelson <rufus-kernel@hackish.org>
CC: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       decklin@red-bean.com
Subject: Re: [PATCH] Hotplug support for several PSX controlers
References: <41BCA915.3030407@tremplin-utc.net> <41BCB420.1080307@hackish.org>
In-Reply-To: <41BCB420.1080307@hackish.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
X-MailScanner-From: eric.piel@tremplin-utc.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Nelson wrote:
 > As I added to the documentation "hot swapping should work (but is not
 > recomended)."  This might make it a bit more likely to work, but still
 > "not recomended."
Yes, I had read it somewhere, I've tried and it works :-)


 > This seems like a reasonable explination when ports float if
 > unconnected.  Your patch does almost the right thing.  First
 > gc_psx_command should take a data[5] argument, that was a logic error on
 > my part.  Second, you compare the calculated length to PSX_LENGTH, which
 > is just saying we read in bytes.  It should check <= 6, which is the
 > longest string of packets possible (buttons, buttons, right, right,
 > left, left, see
 > <http://www.gamesx.com/controldata/psxcont/psxcont.htm>).  Changing to
 > compare to 6 makes the patch look good to me.
I didn't know about the official spec. So changing PSX_LENGTH to 6 makes 
everything even more correct, good.


 >> It probably works on a vanilla 2.6.10-rc3 but I highly recommand to
 >> use the Vojtech's tree which contains an important fix about PSX DDR
 >> (cf http://marc.theaimsgroup.com/?l=linux-kernel&m=110118014804716&w=2).
 >
 >
 > Vojtech already accepted my almost-identical patch when I noticed this
 > in September.  See
 > http://marc.theaimsgroup.com/?l=linux-kernel&m=109571247127456&w=4
Sorry not mentioning your patch, it is actually the one I use. When 
searching for the reference I mistook with the post of Decklin, sorry.


 >> I've heard that Linus wants 2.6.10 ready for Christmas, this patch
 >> should definitetly helps ;-)
 > I'm all for both my previous patch and this one making it into 2.6.10 =)
Is there anyone in particular to tell about those patches? Or is the 
normal way that Vojtech inserts the patches in his tree and Linus pulls 
it when he feels it's stable enough?

Eric


